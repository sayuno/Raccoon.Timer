import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:raccoon_timer/data/database.dart';
import 'package:raccoon_timer/data/providers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late RoutineRepository repo;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    // seed lookups (onCreate runs the migration seed)
    await db.customSelect('SELECT 1').get();
    repo = RoutineRepository(db);
  });

  tearDown(() => db.close());

  test('save interval 4h then restart resets nextTriggerAt to ~now+4h', () async {
    final id = await repo.saveRoutine(RoutinesCompanion(
      name: const Value('Event'),
      typeId: const Value(1),
      scheduleMode: const Value('interval'),
      intervalHours: const Value(4),
      intervalMinutes: const Value(0),
      soundSourceId: const Value(1),
      isEnabled: const Value(true),
    ));

    var r = await db.routineById(id);
    final firstNext = r!.nextTriggerAt!;
    final now1 = DateTime.now().millisecondsSinceEpoch;
    expect(((firstNext - now1) / 3600000).round(), 4);

    // simulate time passing, then restart
    await Future.delayed(const Duration(milliseconds: 50));
    await repo.restartFromNow(r);

    r = await db.routineById(id);
    final now2 = DateTime.now().millisecondsSinceEpoch;
    final delta = (r!.nextTriggerAt! - now2) / 3600000;
    expect(delta, closeTo(4.0, 0.01), reason: 'restart must rebase to now+4h');
    expect(r.nextTriggerAt! > firstNext, isTrue, reason: 'new target must be later');
  });

  test('editing a routine time actually saves (and keeps createdAt)', () async {
    final id = await repo.saveRoutine(RoutinesCompanion(
      name: const Value('Wake'),
      typeId: const Value(1),
      scheduleMode: const Value('daily'),
      atTime: const Value('08:00'),
      soundSourceId: const Value(1),
      isEnabled: const Value(true),
    ));
    final created = (await db.routineById(id))!.createdAt;

    // edit: change the selected time to 09:30
    await repo.saveRoutine(RoutinesCompanion(
      name: const Value('Wake'),
      typeId: const Value(1),
      scheduleMode: const Value('daily'),
      atTime: const Value('09:30'),
      soundSourceId: const Value(1),
      isEnabled: const Value(true),
    ), id: id);

    final r = await db.routineById(id);
    expect(r!.atTime, '09:30', reason: 'edited time must persist');
    expect(r.createdAt, created, reason: 'createdAt must be preserved on edit');
  });

  test('markDone rebases interval to now+4h', () async {
    final id = await repo.saveRoutine(RoutinesCompanion(
      name: const Value('Event'),
      typeId: const Value(1),
      scheduleMode: const Value('interval'),
      intervalHours: const Value(4),
      soundSourceId: const Value(1),
      isEnabled: const Value(true),
    ));
    final before = (await db.routineById(id))!.nextTriggerAt!;
    await Future.delayed(const Duration(milliseconds: 50));
    await repo.markDone((await db.routineById(id))!);
    final after = (await db.routineById(id))!.nextTriggerAt!;
    expect(after > before, isTrue);
    final delta = (after - DateTime.now().millisecondsSinceEpoch) / 3600000;
    expect(delta, closeTo(4.0, 0.01));
  });
}
