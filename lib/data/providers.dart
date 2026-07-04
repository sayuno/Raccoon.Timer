import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/schedule.dart';
import '../services/notification_service.dart';
import 'database.dart';

/// Singleton database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider = Provider<RoutineRepository>((ref) {
  return RoutineRepository(ref.watch(databaseProvider));
});

/// Active routines, sorted by soonest next trigger (paused/no-trigger last).
final routinesProvider = StreamProvider<List<Routine>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchRoutines().map((list) {
    final sorted = [...list];
    sorted.sort((a, b) {
      final an = a.snoozeUntil ?? a.nextTriggerAt;
      final bn = b.snoozeUntil ?? b.nextTriggerAt;
      if (an == null && bn == null) return a.name.compareTo(b.name);
      if (an == null) return 1;
      if (bn == null) return -1;
      return an.compareTo(bn);
    });
    return sorted;
  });
});

/// Lookup: type id -> RoutineType.
final typesProvider = StreamProvider<Map<int, RoutineType>>((ref) {
  final db = ref.watch(databaseProvider);
  return db.watchTypes().map((types) => {for (final t in types) t.id: t});
});

final logsProvider = StreamProvider.family<List<TriggerLog>, int?>((ref, routineId) {
  final db = ref.watch(databaseProvider);
  return db.watchLogs(routineId: routineId);
});

/// One-time app startup: ask for alarm/notification permissions and re-arm all
/// active routines. Watched once from the home screen.
final appStartupProvider = FutureProvider<void>((ref) async {
  await NotificationService.instance.requestPermissions();
  await ref.read(databaseProvider).pruneLogs(days: 30);
  await ref.read(repositoryProvider).rescheduleAll();
});

/// Whether a Spotify account is connected (UI flag in app_setting).
final spotifyConnectedProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(databaseProvider);
  return (await db.getSetting('spotify_connected')) == '1';
});

/// Global sound-mute flag (notifications still fire, silently).
final mutedProvider = FutureProvider<bool>((ref) async {
  final db = ref.watch(databaseProvider);
  return (await db.getSetting('sound_muted')) == '1';
});

/// Sleep-window settings: (enabled, start 'HH:mm', end 'HH:mm').
final quietProvider = FutureProvider<({bool enabled, String start, String end})>((ref) async {
  final db = ref.watch(databaseProvider);
  return (
    enabled: (await db.getSetting('quiet_enabled')) == '1',
    start: (await db.getSetting('quiet_start')) ?? '23:00',
    end: (await db.getSetting('quiet_end')) ?? '07:00',
  );
});

/// One-second ticker driving live countdowns.
final tickerProvider = StreamProvider<int>((ref) {
  return Stream.periodic(
    const Duration(seconds: 1),
    (_) => DateTime.now().millisecondsSinceEpoch,
  );
});

/// Business logic on top of the DB: keeps `nextTriggerAt` fresh.
class RoutineRepository {
  RoutineRepository(this.db);
  final AppDatabase db;

  int get _now => DateTime.now().millisecondsSinceEpoch;

  Future<QuietHours> _quiet() async {
    final enabled = (await db.getSetting('quiet_enabled')) == '1';
    final start = _parseMin(await db.getSetting('quiet_start')) ?? 23 * 60;
    final end = _parseMin(await db.getSetting('quiet_end')) ?? 7 * 60;
    return QuietHours(enabled: enabled, startMin: start, endMin: end);
  }

  Future<bool> _globalMuted() async => (await db.getSetting('sound_muted')) == '1';

  /// Whether a fire at [ms] should be silent: global mute on, or the moment
  /// falls inside the sleep window. The notification still shows either way.
  Future<bool> _silentAt(int ms) async {
    if (await _globalMuted()) return true;
    return (await _quiet()).contains(DateTime.fromMillisecondsSinceEpoch(ms));
  }

  static int? _parseMin(String? hm) {
    if (hm == null) return null;
    final p = hm.split(':');
    if (p.length != 2) return null;
    final h = int.tryParse(p[0]);
    final m = int.tryParse(p[1]);
    if (h == null || m == null) return null;
    return h * 60 + m;
  }

  Future<int> saveRoutine(RoutinesCompanion draft, {int? id}) async {
    // Recompute next trigger from the draft's schedule fields.
    final probe = _companionToRoutine(draft, id: id ?? 0);
    final next = Scheduler.nextTrigger(probe, fromMs: _now);
    final withNext = draft.copyWith(
      id: id == null ? const Value.absent() : Value(id),
      nextTriggerAt: Value(next),
      updatedAt: Value(_now),
      // Set creation time only for new routines; edits must not overwrite it.
      createdAt: id == null ? Value(_now) : const Value.absent(),
    );
    final savedId = await db.upsertRoutine(withNext);
    await _reschedule(id ?? savedId);
    return savedId;
  }

  /// (Re)register the OS alarm for a routine, or cancel it when paused/idle.
  /// Never throws — notification failures must not break DB actions.
  Future<void> _reschedule(int id) async {
    try {
      final r = await db.routineById(id);
      if (r == null) return;
      if (!r.isEnabled || (r.snoozeUntil ?? r.nextTriggerAt) == null) {
        await NotificationService.instance.cancel(id);
        return;
      }
      final type = await db.typeById(r.typeId);
      final target = r.snoozeUntil ?? r.nextTriggerAt;
      final silent = target != null && await _silentAt(target);
      await NotificationService.instance
          .scheduleNext(r, typeIcon: type?.icon ?? '⏰', silent: silent);
    } catch (_) {}
  }

  /// Toggle global sound mute (notifications still fire, just silent) and re-arm.
  Future<void> setMuted(bool muted) async {
    await db.setSetting('sound_muted', muted ? '1' : '0');
    await rescheduleAll();
  }

  /// Save sleep-window settings and re-arm all alarms with the new silent state.
  Future<void> setQuietHours({required bool enabled, required String start, required String end}) async {
    await db.setSetting('quiet_enabled', enabled ? '1' : '0');
    await db.setSetting('quiet_start', start);
    await db.setSetting('quiet_end', end);
    await rescheduleAll();
  }

  /// Re-arm every active routine — call on app start (covers edits made while
  /// the app was closed and OS restarts). Also catches up past-due routines so
  /// the countdown never stays frozen at 00:00.
  Future<void> rescheduleAll() async {
    for (final r in await db.activeEnabledRoutines()) {
      final target = r.snoozeUntil ?? r.nextTriggerAt;
      if (target != null && target < _now) {
        // Fire moment passed while the app was closed → log missed + advance.
        await db.logTrigger(TriggerLogsCompanion.insert(
          routineId: r.id,
          scheduledAt: target,
          statusId: 5, // missed
          createdAt: _now,
        ));
        await db.patchRoutine(r.id, const RoutinesCompanion(snoozeUntil: Value(null)));
        await recompute(r.id); // sets a fresh future nextTriggerAt + reschedules
      } else {
        await _reschedule(r.id);
      }
    }
  }

  Future<void> setEnabled(Routine r, bool enabled) async {
    await db.setEnabled(r.id, enabled);
    if (enabled) {
      await recompute(r.id);
    } else {
      await NotificationService.instance.cancel(r.id);
    }
  }

  Future<void> recompute(int id) async {
    final r = await db.routineById(id);
    if (r == null) return;
    final next = Scheduler.nextTrigger(r, fromMs: _now);
    await db.patchRoutine(id, RoutinesCompanion(nextTriggerAt: Value(next)));
    await _reschedule(id);
  }

  /// Rebase the countdown to "now" — e.g. an every-4h routine you dealt with an
  /// hour late restarts its 4h from this moment. Clears any active snooze.
  Future<void> restartFromNow(Routine r) async {
    final next = Scheduler.nextTrigger(r, fromMs: _now);
    await db.patchRoutine(r.id, RoutinesCompanion(
      nextTriggerAt: Value(next),
      snoozeUntil: const Value(null),
    ));
    await _reschedule(r.id);
  }

  Future<void> markDone(Routine r) async {
    await db.logTrigger(TriggerLogsCompanion.insert(
      routineId: r.id,
      scheduledAt: r.nextTriggerAt ?? _now,
      firedAt: Value(_now),
      statusId: 3, // done
      createdAt: _now,
    ));
    // clear snooze + advance schedule
    await db.patchRoutine(r.id, const RoutinesCompanion(snoozeUntil: Value(null)));
    await recompute(r.id);
  }

  Future<void> snooze(Routine r, int minutes) async {
    final until = _now + minutes * 60 * 1000;
    await db.logTrigger(TriggerLogsCompanion.insert(
      routineId: r.id,
      scheduledAt: r.nextTriggerAt ?? _now,
      firedAt: Value(_now),
      statusId: 4, // snoozed
      createdAt: _now,
    ));
    await db.patchRoutine(r.id, RoutinesCompanion(snoozeUntil: Value(until)));
    await _reschedule(r.id);
  }

  Future<void> archive(Routine r) async {
    await NotificationService.instance.cancel(r.id);
    await db.archiveRoutine(r.id);
  }

  Future<int> createType(RoutineTypesCompanion c) => db.createType(c);

  // Build a Routine row from a companion to feed the pure Scheduler.
  Routine _companionToRoutine(RoutinesCompanion c, {required int id}) {
    return Routine(
      id: id,
      name: c.name.present ? c.name.value : '',
      typeId: c.typeId.present ? c.typeId.value : 0,
      scheduleMode: c.scheduleMode.present ? c.scheduleMode.value : 'daily',
      oneShotAt: c.oneShotAt.present ? c.oneShotAt.value : null,
      atTime: c.atTime.present ? c.atTime.value : null,
      intervalHours: c.intervalHours.present ? c.intervalHours.value : null,
      intervalMinutes: c.intervalMinutes.present ? c.intervalMinutes.value : null,
      windowStart: c.windowStart.present ? c.windowStart.value : null,
      windowEnd: c.windowEnd.present ? c.windowEnd.value : null,
      weekdaysMask: c.weekdaysMask.present ? c.weekdaysMask.value : null,
      soundSourceId: c.soundSourceId.present ? c.soundSourceId.value : 1,
      soundRef: c.soundRef.present ? c.soundRef.value : null,
      soundLabel: c.soundLabel.present ? c.soundLabel.value : null,
      volume: c.volume.present ? c.volume.value : 80,
      fadeIn: c.fadeIn.present ? c.fadeIn.value : false,
      isEnabled: c.isEnabled.present ? c.isEnabled.value : true,
      nextTriggerAt: null,
      snoozeUntil: null,
      isActive: true,
      createdAt: _now,
      updatedAt: _now,
    );
  }
}
