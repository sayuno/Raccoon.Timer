import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

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
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  /// Schedule the next fire of [r] at its `nextTriggerAt`/`snoozeUntil`.
  Future<void> scheduleNext(Routine r, {required String typeIcon}) async {
    final at = r.snoozeUntil ?? r.nextTriggerAt;
    if (at == null || !r.isEnabled) {
      await cancel(r.id);
      return;
    }
    final when = tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, at);

    await _plugin.zonedSchedule(
      id: r.id,
      title: '$typeIcon ${r.name}',
      body: 'Hora da rotina',
      scheduledDate: when,
      notificationDetails: NotificationDetails(
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
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: r.id.toString(),
    );
  }

  Future<void> cancel(int routineId) => _plugin.cancel(id: routineId);
}
