import '../data/database.dart';

/// The three ways a routine can fire.
enum ScheduleMode {
  daily('daily'),
  interval('interval'),
  oneShot('one_shot');

  const ScheduleMode(this.value);
  final String value;

  static ScheduleMode fromValue(String v) =>
      ScheduleMode.values.firstWhere((m) => m.value == v, orElse: () => ScheduleMode.daily);
}

/// Weekday bitmask helpers. Mon=1, Tue=2, Wed=4, Thu=8, Fri=16, Sat=32, Sun=64.
/// Matches Dart's [DateTime.weekday] (Mon=1..Sun=7) mapped to bit (1 << (wd-1)).
class Weekdays {
  static int bit(int dartWeekday) => 1 << (dartWeekday - 1);

  static bool contains(int? mask, int dartWeekday) {
    if (mask == null || mask == 0) return true; // null/0 = every day
    return (mask & bit(dartWeekday)) != 0;
  }

  static int toggle(int mask, int dartWeekday) => mask ^ bit(dartWeekday);
}

/// Pure next-trigger computation. Returns epoch ms of the next fire strictly
/// after [fromMs], or null if the routine can no longer fire (past one_shot).
class Scheduler {
  /// Computes the next trigger for [r] after [fromMs].
  static int? nextTrigger(Routine r, {required int fromMs}) {
    final from = DateTime.fromMillisecondsSinceEpoch(fromMs);
    switch (ScheduleMode.fromValue(r.scheduleMode)) {
      case ScheduleMode.oneShot:
        final at = r.oneShotAt;
        if (at == null) return null;
        return at > fromMs ? at : null;

      case ScheduleMode.daily:
        return _nextDaily(r, from);

      case ScheduleMode.interval:
        return _nextInterval(r, from);
    }
  }

  static int? _nextDaily(Routine r, DateTime from) {
    final hm = _parseHm(r.atTime);
    if (hm == null) return null;
    // scan up to 8 days ahead to honor the weekday filter
    for (var i = 0; i <= 8; i++) {
      final day = DateTime(from.year, from.month, from.day + i, hm.$1, hm.$2);
      if (day.isAfter(from) && Weekdays.contains(r.weekdaysMask, day.weekday)) {
        return day.millisecondsSinceEpoch;
      }
    }
    return null;
  }

  static int? _nextInterval(Routine r, DateTime from) {
    final stepMin = (r.intervalHours ?? 0) * 60 + (r.intervalMinutes ?? 0);
    if (stepMin <= 0) return null;
    final step = Duration(minutes: stepMin);

    var candidate = from.add(step);
    final winStart = _parseHm(r.windowStart);
    final winEnd = _parseHm(r.windowEnd);

    // Advance the candidate until it lands on an allowed weekday and, if a
    // window is set, inside [winStart, winEnd]. Cap iterations for safety.
    for (var i = 0; i < 500; i++) {
      final okDay = Weekdays.contains(r.weekdaysMask, candidate.weekday);
      final okWindow = _inWindow(candidate, winStart, winEnd);
      if (okDay && okWindow) return candidate.millisecondsSinceEpoch;

      if (!okDay) {
        // jump to start of next day
        final next = DateTime(candidate.year, candidate.month, candidate.day + 1);
        candidate = winStart == null
            ? next
            : DateTime(next.year, next.month, next.day, winStart.$1, winStart.$2);
      } else if (winStart != null && winEnd != null) {
        final startToday = DateTime(candidate.year, candidate.month, candidate.day, winStart.$1, winStart.$2);
        if (candidate.isBefore(startToday)) {
          candidate = startToday;
        } else {
          // past the window end → next day's window start
          final n = DateTime(candidate.year, candidate.month, candidate.day + 1, winStart.$1, winStart.$2);
          candidate = n;
        }
      } else {
        candidate = candidate.add(step);
      }
    }
    return null;
  }

  static bool _inWindow(DateTime t, (int, int)? start, (int, int)? end) {
    if (start == null || end == null) return true;
    final mins = t.hour * 60 + t.minute;
    final s = start.$1 * 60 + start.$2;
    final e = end.$1 * 60 + end.$2;
    return mins >= s && mins <= e;
  }

  static (int, int)? _parseHm(String? hm) {
    if (hm == null) return null;
    final parts = hm.split(':');
    if (parts.length != 2) return null;
    final h = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);
    if (h == null || m == null) return null;
    return (h, m);
  }
}
