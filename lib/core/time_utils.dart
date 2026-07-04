/// Format helpers for countdowns and clock labels.
class TimeUtils {
  /// Countdown like `01:23:45` (or `23:45` when under an hour) from a duration
  /// in milliseconds. Never negative.
  static String countdown(int ms) {
    if (ms < 0) ms = 0;
    final totalSec = ms ~/ 1000;
    final h = totalSec ~/ 3600;
    final m = (totalSec % 3600) ~/ 60;
    final s = totalSec % 60;
    String two(int n) => n.toString().padLeft(2, '0');
    if (h > 0) return '${two(h)}:${two(m)}:${two(s)}';
    return '${two(m)}:${two(s)}';
  }

  /// `em 01:23:45` style label for a future epoch-ms target.
  static String untilLabel(int? targetMs, {int? nowMs}) {
    if (targetMs == null) return 'pausado';
    final now = nowMs ?? DateTime.now().millisecondsSinceEpoch;
    return 'em ${countdown(targetMs - now)}';
  }

  /// `HH:mm` from epoch ms.
  static String clock(int ms) {
    final d = DateTime.fromMillisecondsSinceEpoch(ms);
    return '${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
  }

  /// Human-friendly schedule summary for a routine card/detail.
  static String scheduleSummary({
    required String mode,
    String? atTime,
    int? intervalHours,
    int? intervalMinutes,
    int? weekdaysMask,
    int? oneShotAt,
  }) {
    switch (mode) {
      case 'daily':
        return '${atTime ?? '--:--'} · ${weekdaysLabel(weekdaysMask)}';
      case 'interval':
        final h = intervalHours ?? 0;
        final m = intervalMinutes ?? 0;
        final parts = <String>[];
        if (h > 0) parts.add('${h}h');
        if (m > 0) parts.add('${m}min');
        return 'a cada ${parts.join(' ')}';
      case 'one_shot':
        if (oneShotAt == null) return 'data única';
        final d = DateTime.fromMillisecondsSinceEpoch(oneShotAt);
        return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')} ${clock(oneShotAt)}';
      default:
        return '';
    }
  }

  static const _wd = ['S', 'T', 'Q', 'Q', 'S', 'S', 'D']; // Mon..Sun

  static String weekdaysLabel(int? mask) {
    if (mask == null || mask == 0) return 'todos dias';
    final on = <String>[];
    for (var i = 0; i < 7; i++) {
      if ((mask & (1 << i)) != 0) on.add(_wd[i]);
    }
    if (on.length == 7) return 'todos dias';
    if (mask == 0x1F) return 'seg–sex'; // Mon..Fri
    return on.join('/');
  }
}
