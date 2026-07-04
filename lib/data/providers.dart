import 'dart:async';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/schedule.dart';
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

  Future<int> saveRoutine(RoutinesCompanion draft, {int? id}) async {
    // Recompute next trigger from the draft's schedule fields.
    final probe = _companionToRoutine(draft, id: id ?? 0);
    final next = Scheduler.nextTrigger(probe, fromMs: _now);
    final withNext = draft.copyWith(
      id: id == null ? const Value.absent() : Value(id),
      nextTriggerAt: Value(next),
      updatedAt: Value(_now),
      createdAt: draft.createdAt.present ? draft.createdAt : Value(_now),
    );
    return db.upsertRoutine(withNext);
  }

  Future<void> setEnabled(Routine r, bool enabled) async {
    await db.setEnabled(r.id, enabled);
    if (enabled) await recompute(r.id);
  }

  Future<void> recompute(int id) async {
    final r = await db.routineById(id);
    if (r == null) return;
    final next = Scheduler.nextTrigger(r, fromMs: _now);
    await db.upsertRoutine(RoutinesCompanion(id: Value(id), nextTriggerAt: Value(next)));
  }

  /// Rebase the countdown to "now" — e.g. an every-4h routine you dealt with an
  /// hour late restarts its 4h from this moment. Clears any active snooze.
  Future<void> restartFromNow(Routine r) async {
    final next = Scheduler.nextTrigger(r, fromMs: _now);
    await db.upsertRoutine(RoutinesCompanion(
      id: Value(r.id),
      nextTriggerAt: Value(next),
      snoozeUntil: const Value(null),
    ));
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
    await db.upsertRoutine(RoutinesCompanion(id: Value(r.id), snoozeUntil: const Value(null)));
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
    await db.upsertRoutine(RoutinesCompanion(id: Value(r.id), snoozeUntil: Value(until)));
  }

  Future<void> archive(Routine r) => db.archiveRoutine(r.id);

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
