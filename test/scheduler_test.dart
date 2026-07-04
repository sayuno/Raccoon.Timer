import 'package:flutter_test/flutter_test.dart';
import 'package:raccoon_timer/core/schedule.dart';
import 'package:raccoon_timer/data/database.dart';

Routine _interval({required int hours, int minutes = 0, int? weekdaysMask}) {
  final now = DateTime(2026, 7, 4, 11, 0).millisecondsSinceEpoch;
  return Routine(
    id: 1,
    name: 'Event',
    typeId: 1,
    scheduleMode: 'interval',
    oneShotAt: null,
    atTime: null,
    intervalHours: hours,
    intervalMinutes: minutes,
    windowStart: null,
    windowEnd: null,
    weekdaysMask: weekdaysMask,
    soundSourceId: 1,
    soundRef: null,
    soundLabel: null,
    volume: 80,
    fadeIn: false,
    isEnabled: true,
    nextTriggerAt: null,
    snoozeUntil: null,
    isActive: true,
    createdAt: now,
    updatedAt: now,
  );
}

void main() {
  test('interval 4h → next trigger is exactly 4h from now', () {
    final from = DateTime(2026, 7, 4, 11, 0).millisecondsSinceEpoch;
    final next = Scheduler.nextTrigger(_interval(hours: 4), fromMs: from);
    expect(next, isNotNull);
    final deltaHours = (next! - from) / (1000 * 60 * 60);
    expect(deltaHours, 4.0);
  });

  test('interval ignores a leaked weekday mask', () {
    final from = DateTime(2026, 7, 4, 11, 0).millisecondsSinceEpoch;
    // mask that excludes today — must NOT push the interval far out
    final next = Scheduler.nextTrigger(_interval(hours: 4, weekdaysMask: 64), fromMs: from);
    final deltaHours = (next! - from) / (1000 * 60 * 60);
    expect(deltaHours, 4.0);
  });

  test('restart-style recompute from a later moment stays 4h', () {
    // simulate pressing restart 3h56m into the countdown
    final later = DateTime(2026, 7, 4, 14, 56).millisecondsSinceEpoch;
    final next = Scheduler.nextTrigger(_interval(hours: 4), fromMs: later);
    final deltaHours = (next! - later) / (1000 * 60 * 60);
    expect(deltaHours, 4.0);
  });
}
