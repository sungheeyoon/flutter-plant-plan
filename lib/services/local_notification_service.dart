import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/home');
    DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(
        android: androidInitializationSettings,
        iOS: darwinInitializationSettings);

    await _localNotificationService.initialize(settings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
  }

  Future<void> showNotificaion({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    return await _localNotificationService.show(id, title, body, details);
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    try {
      print('id $id');
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) async {
    print('payload $details');
  }

  Future<void> scheduleAlarmNotifications(PlantModel plant) async {
    String title =
        plant.information.name + (plant.alias != "" ? '(${plant.alias})' : '');
    for (AlarmModel alarm in plant.alarms) {
      String body = '';
      String channelId = alarm.id;
      String channelName = '';
      String channelDescription = '';

      switch (alarm.field) {
        case PlantField.watering:
          body = '$title의 물주기 날짜입니다.';
          channelName = 'watering';
          channelDescription = '$title의 물주기 알림';
          break;
        case PlantField.repotting:
          body = '$title의 분갈이 날짜입니다.';
          channelName = 'repotting';
          channelDescription = '$title의 분갈이 알림';
          break;
        case PlantField.nutrient:
          body = '$title에게 영양제를 주는 날짜입니다.';
          channelName = 'nutrient';
          channelDescription = '$title의 영양제 알림';
          break;
        case PlantField.none:
          break;
      }

      AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
      );

      NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      if (alarm.isOn) {
        if (alarm.repeat == 0) {
          tz.TZDateTime scheduledDate =
              tz.TZDateTime.from(alarm.startTime, tz.local);
          if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
            await _localNotificationService.zonedSchedule(
              alarm.id.hashCode,
              title,
              body,
              scheduledDate,
              platformChannelSpecifics,
              uiLocalNotificationDateInterpretation:
                  UILocalNotificationDateInterpretation.absoluteTime,
            );
          }
        } else if (alarm.repeat > 0) {
          await scheduleRepeatingNotification(
            alarm.id.hashCode.toString().substring(0, 6),
            title,
            body,
            tz.TZDateTime.from(alarm.startTime, tz.local),
            alarm,
          );
        }
      }
    }
  }

  Future<void> scheduleRepeatingNotification(String prefix, String title,
      String body, tz.TZDateTime initialDateTime, AlarmModel alarm) async {
    int alarmsToSchedule = 5;

    int count = 0;
    for (int i = 1; i <= alarmsToSchedule; i++) {
      tz.TZDateTime scheduledDate =
          initialDateTime.add(Duration(days: i * alarm.repeat));

      if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local)) &&
          !_isDateInOffDates(scheduledDate, alarm.offDates)) {
        int actualNotificationId = int.parse('$prefix$count');

        AndroidNotificationDetails androidPlatformChannelSpecifics =
            const AndroidNotificationDetails(
          'channel_id',
          'channel_name',
          channelDescription: 'channel_description',
          importance: Importance.high,
          priority: Priority.high,
          ticker: 'ticker',
        );

        NotificationDetails platformChannelSpecifics =
            NotificationDetails(android: androidPlatformChannelSpecifics);

        await _localNotificationService.zonedSchedule(
          actualNotificationId,
          title,
          body,
          scheduledDate,
          platformChannelSpecifics,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime,
          payload: scheduledDate.toString(),
        );
        count++;
      }
    }
  }

  bool _isDateInOffDates(tz.TZDateTime date, List<DateTime> offDates) {
    DateTime localDate = date.toLocal();

    return offDates.any((offDate) =>
        offDate.year == localDate.year &&
        offDate.month == localDate.month &&
        offDate.day == localDate.day);
  }

  Future<void> deleteNotificationsWithPrefix(String prefix) async {
    List<PendingNotificationRequest> pendingNotifications =
        await retrievePendingNotifications();

    final realPrefix = prefix.hashCode.toString().substring(0, 6);
    for (var notification in pendingNotifications) {
      if (notification.id.toString().startsWith(realPrefix)) {
        await _localNotificationService.cancel(notification.id);
        print('Notification with ID ${notification.id} deleted.');
      } else {
        print('Notification with ID ${notification.id} not deleted.');
      }
    }
  }

  Future<void> rescheduleNotifications(PlantModel plant) async {
    await deleteNotificationsWithPrefix(plant.docId);

    await scheduleAlarmNotifications(plant);
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails platformChannelSpecifics,
    required bool shouldSchedule,
  }) async {
    // 현재 시간 이후에만 알림을 예약
    if (shouldSchedule && scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
      await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        scheduledDate,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        payload: scheduledDate.toString(),
      );
    }
  }

  Future<void> deleteAllNotifications() async {
    _localNotificationService.cancelAll();
  }

  Future<List<ActiveNotification>> retrieveNotifications() async {
    List<ActiveNotification> activeNotifications = [];
    try {
      activeNotifications =
          await _localNotificationService.getActiveNotifications();
    } catch (e) {
      print('Error retrieving notifications: $e');
    }
    return activeNotifications;
  }

  Future<List<PendingNotificationRequest>>
      retrievePendingNotifications() async {
    try {
      return await _localNotificationService.pendingNotificationRequests();
    } catch (e) {
      print('Error retrieving pending notifications: $e');
      return [];
    }
  }
}
