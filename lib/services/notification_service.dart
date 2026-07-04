import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import '../core/schedule.dart';
import '../data/database.dart';

/// Schedules exact, full-screen alarm notifications for routines.
///
/// On Android this uses `zonedSchedule` with `AndroidScheduleMode.exactAllowWhileIdle`
/// and a full-screen intent so the [FireScreen] can be shown over the lock screen.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();
  bool _ready = false;

  static const _channel = AndroidNotificationChannel(
    'routine_alarms',
    'Alarmes de rotina',
    description: 'Disparos das suas rotinas',
    importance: Importance.max,
    playSound: true,
  );

  Future<void> init({
    void Function(String? payload)? onTapPayload,
  }) async {
    if (_ready) return;
    tzdata.initializeTimeZones();
    try {
      final localName = (await FlutterTimezone.getLocalTimezone()).identifier;
      tz.setLocalLocation(tz.getLocation(localName));
    } catch (_) {
      // Fall back to UTC if the platform zone can't be resolved.
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
      onDidReceiveNotificationResponse: (resp) => onTapPayload?.call(resp.payload),
    );

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    _ready = true;
  }

  Future<void> requestPermissions() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
      await android?.requestExactAlarmsPermission();
    } catch (_) {}
  }

  /// Schedule the next fire of [r] at its `nextTriggerAt`/`snoozeUntil`.
  ///
  /// Never throws: if exact-alarm permission is denied (common on MIUI/HyperOS)
  /// it silently falls back to an inexact alarm. A scheduling failure must not
  /// break the caller (saving a routine, marking Done, snoozing, etc.).
  Future<void> scheduleNext(Routine r, {required String typeIcon}) async {
    final at = r.snoozeUntil ?? r.nextTriggerAt;
    if (at == null || !r.isEnabled) {
      await cancel(r.id);
      return;
    }
    final when = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, at);

    // A plain daily routine (fixed time, every day) can self-repeat via the OS
    // even with the app killed. Weekday-filtered daily, interval and one-shot
    // are single-shot and re-armed on ack / app open.
    final isPlainDaily = ScheduleMode.fromValue(r.scheduleMode) == ScheduleMode.daily &&
        (r.weekdaysMask == null || r.weekdaysMask == 0);

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channel.id,
        _channel.name,
        channelDescription: _channel.description,
        importance: Importance.max,
        priority: Priority.max,
        fullScreenIntent: true,
        category: AndroidNotificationCategory.alarm,
      ),
      iOS: const DarwinNotificationDetails(),
    );
    final match = isPlainDaily ? DateTimeComponents.time : null;

    Future<void> doSchedule(AndroidScheduleMode mode) => _plugin.zonedSchedule(
          id: r.id,
          title: '$typeIcon ${r.name}',
          body: 'Hora da rotina',
          scheduledDate: when,
          notificationDetails: details,
          androidScheduleMode: mode,
          matchDateTimeComponents: match,
          payload: r.id.toString(),
        );

    try {
      await doSchedule(AndroidScheduleMode.exactAllowWhileIdle);
    } catch (_) {
      // Exact alarms not permitted → best-effort inexact.
      try {
        await doSchedule(AndroidScheduleMode.inexactAllowWhileIdle);
      } catch (_) {
        // Give up silently; the in-app countdown still works.
      }
    }
  }

  Future<void> cancel(int routineId) async {
    try {
      await _plugin.cancel(id: routineId);
    } catch (_) {}
  }

  /// Payload of the notification that cold-started the app (null otherwise).
  Future<String?> launchPayload() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      return details?.notificationResponse?.payload;
    }
    return null;
  }
}
