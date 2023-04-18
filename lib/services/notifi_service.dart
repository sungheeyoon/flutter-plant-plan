import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:io' show Platform;

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    if (Platform.isAndroid) {
      _requestAndroidPermission();
    }

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/home');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (int id, String? title, String? body,
                String? payload) async {});

    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        var a = notificationResponse.id ?? 0;
        await cancel(a);
      },
    );
  }

  _requestIOSPermission() async {
    return await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  _requestAndroidPermission() async {
    return await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future scheduleNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime scheduledNotificationDateTime}) async {
    await notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(
        scheduledNotificationDateTime,
        tz.local,
      ),
      await notificationDetails(),
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future periodicallyNotification({
    int id = 0,
    String? title,
    String? body,
    required RepeatInterval repeatInterval,
  }) async {
    await notificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      repeatInterval,
      await notificationDetails(),
    );
  }

  Future cancel(int id) async {
    return await notificationsPlugin.cancel(id);
  }

  tz.TZDateTime makeDate(
      {required DateTime scheduledNotificationDateTime, required int days}) {
    var now = tz.TZDateTime.now(tz.local);
    var when = tz.TZDateTime.from(
      scheduledNotificationDateTime,
      tz.local,
    );
    if (when.isBefore(now)) {
      return when.add(Duration(days: days));
    } else {
      return when;
    }
  }
}
