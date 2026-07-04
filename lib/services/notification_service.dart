import 'dart:typed_data';

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

  // Loud alarm channel. New id (v2) because channel sound/usage are immutable
  // once created — a rename forces Android to pick up the alarm-stream sound.
  static const _channel = AndroidNotificationChannel(
    'routine_alarms_v2',
    'Alarmes de rotina',
    description: 'Disparos das suas rotinas',
    importance: Importance.max,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('alarm1'),
    audioAttributesUsage: AudioAttributesUsage.alarm,
  );

  // Silent channel — used during global mute / sleep window. Android 8+ ties
  // sound to the channel, so a silent fire must go through its own channel.
  static const _silentChannel = AndroidNotificationChannel(
    'routine_alarms_silent',
    'Alarmes silenciados',
    description: 'Disparos sem som (mudo / modo sono)',
    importance: Importance.high,
    playSound: false,
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

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await androidImpl?.createNotificationChannel(_channel);
    await androidImpl?.createNotificationChannel(_silentChannel);

    _ready = true;
  }

  Future<void> requestPermissions() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      await android?.requestNotificationsPermission();
      await android?.requestExactAlarmsPermission();
      await android?.requestFullScreenIntentPermission();
    } catch (_) {}
  }

  /// Whether the OS currently allows exact alarms (Android 12+). If false, alarms
  /// may be delayed or dropped — the user must grant "Alarms & reminders".
  Future<bool> exactAlarmsAllowed() async {
    try {
      final android = _plugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      return (await android?.canScheduleExactNotifications()) ?? true;
    } catch (_) {
      return true;
    }
  }

  /// How many alarms are currently scheduled with the OS (diagnostic).
  Future<int> pendingCount() async {
    try {
      return (await _plugin.pendingNotificationRequests()).length;
    } catch (_) {
      return 0;
    }
  }

  /// Schedule the next fire of [r] at its `nextTriggerAt`/`snoozeUntil`.
  ///
  /// Never throws: if exact-alarm permission is denied (common on MIUI/HyperOS)
  /// it silently falls back to an inexact alarm. A scheduling failure must not
  /// break the caller (saving a routine, marking Done, snoozing, etc.).
  Future<void> scheduleNext(Routine r, {required String typeIcon, bool silent = false}) async {
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

    // silent = global mute or sleep window: still show the notification, no sound.
    final ch = silent ? _silentChannel : _channel;
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        ch.id,
        ch.name,
        channelDescription: ch.description,
        importance: silent ? Importance.high : Importance.max,
        priority: silent ? Priority.high : Priority.max,
        fullScreenIntent: !silent,
        category: AndroidNotificationCategory.alarm,
        playSound: !silent,
        sound: silent ? null : const RawResourceAndroidNotificationSound('alarm1'),
        audioAttributesUsage:
            silent ? AudioAttributesUsage.notification : AudioAttributesUsage.alarm,
        // FLAG_INSISTENT (4): loop the alarm sound until dismissed (loud only).
        additionalFlags: silent ? null : Int32List.fromList(<int>[4]),
      ),
      iOS: DarwinNotificationDetails(presentSound: !silent),
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

    // alarmClock (AlarmManager.setAlarmClock) is the most reliable: it fires in
    // Doze, is treated as a user alarm (survives battery optimization / OEM
    // killers better) and needs no exact-alarm permission. Fall back if unsupported.
    try {
      await doSchedule(AndroidScheduleMode.alarmClock);
    } catch (_) {
      try {
        await doSchedule(AndroidScheduleMode.exactAllowWhileIdle);
      } catch (_) {
        try {
          await doSchedule(AndroidScheduleMode.inexactAllowWhileIdle);
        } catch (_) {
          // Give up silently; the in-app countdown still works.
        }
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
