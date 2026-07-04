import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

// ---------------------------------------------------------------------------
// Lookup tables
// ---------------------------------------------------------------------------

class RoutineTypes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get labelPt => text()();
  TextColumn get icon => text()();
  TextColumn get color => text()();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class SoundSources extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().unique()();
  TextColumn get labelPt => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

class TriggerStatuses extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text().unique()();
  TextColumn get labelPt => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

// ---------------------------------------------------------------------------
// Core tables — timestamps stored as epoch milliseconds (int)
// ---------------------------------------------------------------------------

class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get typeId => integer().references(RoutineTypes, #id)();

  /// 'one_shot' | 'interval' | 'daily'
  TextColumn get scheduleMode => text()();

  IntColumn get oneShotAt => integer().nullable()(); // one_shot: epoch ms
  TextColumn get atTime => text().nullable()(); // daily: 'HH:mm'
  IntColumn get intervalHours => integer().nullable()();
  IntColumn get intervalMinutes => integer().nullable()();
  TextColumn get windowStart => text().nullable()(); // interval active window
  TextColumn get windowEnd => text().nullable()();
  IntColumn get weekdaysMask => integer().nullable()(); // Mon=1..Sun=64

  IntColumn get soundSourceId => integer().references(SoundSources, #id)();
  TextColumn get soundRef => text().nullable()();
  TextColumn get soundLabel => text().nullable()();
  IntColumn get volume => integer().withDefault(const Constant(80))();
  BoolColumn get fadeIn => boolean().withDefault(const Constant(false))();

  BoolColumn get isEnabled => boolean().withDefault(const Constant(true))();
  IntColumn get nextTriggerAt => integer().nullable()();
  IntColumn get snoozeUntil => integer().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();
}

class TriggerLogs extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId =>
      integer().references(Routines, #id, onDelete: KeyAction.cascade)();
  IntColumn get scheduledAt => integer()();
  IntColumn get firedAt => integer().nullable()();
  IntColumn get statusId => integer().references(TriggerStatuses, #id)();
  IntColumn get createdAt => integer()();
}

class AppSettings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}

// ---------------------------------------------------------------------------
// Database
// ---------------------------------------------------------------------------

@DriftDatabase(
  tables: [
    RoutineTypes,
    SoundSources,
    TriggerStatuses,
    Routines,
    TriggerLogs,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seed();
        },
      );

  Future<void> _seed() async {
    // Built-in routine types (is_system = 1)
    await batch((b) {
      b.insertAll(routineTypes, [
        RoutineTypesCompanion.insert(
            id: const Value(1), name: 'medicine', labelPt: 'Remédio', icon: '💊', color: '#38BDF8', isSystem: const Value(true)),
        RoutineTypesCompanion.insert(
            id: const Value(2), name: 'water', labelPt: 'Água', icon: '💧', color: '#22D3EE', isSystem: const Value(true)),
        RoutineTypesCompanion.insert(
            id: const Value(3), name: 'workout', labelPt: 'Treino', icon: '🏋', color: '#F5C542', isSystem: const Value(true)),
        RoutineTypesCompanion.insert(
            id: const Value(4), name: 'sleep', labelPt: 'Dormir', icon: '😴', color: '#818CF8', isSystem: const Value(true)),
        RoutineTypesCompanion.insert(
            id: const Value(5), name: 'study', labelPt: 'Estudo', icon: '📚', color: '#34D399', isSystem: const Value(true)),
      ]);
      b.insertAll(soundSources, [
        SoundSourcesCompanion.insert(id: const Value(1), name: 'default_alarm', labelPt: 'Alarme padrão'),
        SoundSourcesCompanion.insert(id: const Value(2), name: 'local', labelPt: 'Música do celular'),
        SoundSourcesCompanion.insert(id: const Value(3), name: 'spotify', labelPt: 'Spotify'),
      ]);
      b.insertAll(triggerStatuses, [
        TriggerStatusesCompanion.insert(id: const Value(1), name: 'scheduled', labelPt: 'Agendado'),
        TriggerStatusesCompanion.insert(id: const Value(2), name: 'fired', labelPt: 'Disparado'),
        TriggerStatusesCompanion.insert(id: const Value(3), name: 'done', labelPt: 'Feito'),
        TriggerStatusesCompanion.insert(id: const Value(4), name: 'snoozed', labelPt: 'Soneca'),
        TriggerStatusesCompanion.insert(id: const Value(5), name: 'missed', labelPt: 'Perdido'),
      ]);
      b.insertAll(appSettings, [
        AppSettingsCompanion.insert(key: 'theme', value: const Value('dark')),
        AppSettingsCompanion.insert(key: 'clock_24h', value: const Value('1')),
        AppSettingsCompanion.insert(key: 'default_snooze_min', value: const Value('5')),
        AppSettingsCompanion.insert(key: 'default_sound_source_id', value: const Value('1')),
        AppSettingsCompanion.insert(key: 'spotify_connected', value: const Value('0')),
      ]);
    });
  }

  // ---- Reads -------------------------------------------------------------

  /// Active routines (order applied in the UI layer).
  Stream<List<Routine>> watchRoutines() {
    return (select(routines)..where((r) => r.isActive.equals(true))).watch();
  }

  Future<List<RoutineType>> activeTypes() =>
      (select(routineTypes)..where((t) => t.isActive.equals(true))).get();

  Stream<List<RoutineType>> watchTypes() =>
      (select(routineTypes)..where((t) => t.isActive.equals(true))).watch();

  Future<Routine?> routineById(int id) =>
      (select(routines)..where((r) => r.id.equals(id))).getSingleOrNull();

  Stream<List<TriggerLog>> watchLogs({int? routineId, int limit = 200}) {
    final q = select(triggerLogs)
      ..orderBy([(l) => OrderingTerm.desc(l.scheduledAt)])
      ..limit(limit);
    if (routineId != null) q.where((l) => l.routineId.equals(routineId));
    return q.watch();
  }

  // ---- Writes ------------------------------------------------------------

  Future<int> upsertRoutine(RoutinesCompanion c) => into(routines).insertOnConflictUpdate(c);

  Future<void> setEnabled(int id, bool enabled) =>
      (update(routines)..where((r) => r.id.equals(id)))
          .write(RoutinesCompanion(isEnabled: Value(enabled)));

  Future<void> archiveRoutine(int id) =>
      (update(routines)..where((r) => r.id.equals(id)))
          .write(const RoutinesCompanion(isActive: Value(false)));

  Future<int> createType(RoutineTypesCompanion c) => into(routineTypes).insert(c);

  Future<void> logTrigger(TriggerLogsCompanion c) => into(triggerLogs).insert(c);

  /// Delete trigger logs older than [days] (default 30) — housekeeping.
  Future<int> pruneLogs({int days = 30}) {
    final cutoff = DateTime.now().subtract(Duration(days: days)).millisecondsSinceEpoch;
    return (delete(triggerLogs)..where((l) => l.createdAt.isSmallerThanValue(cutoff))).go();
  }

  Future<String?> getSetting(String key) async {
    final row = await (select(appSettings)..where((s) => s.key.equals(key))).getSingleOrNull();
    return row?.value;
  }

  Future<void> setSetting(String key, String value) =>
      into(appSettings).insertOnConflictUpdate(
          AppSettingsCompanion.insert(key: key, value: Value(value)));
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'raccoon_timer.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
