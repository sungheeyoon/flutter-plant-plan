import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
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

  Future<bool> checkNotificationPermission() async {
    final settings =
        await _localNotificationService.getNotificationAppLaunchDetails();
    return settings?.didNotificationLaunchApp ?? false;
  }

  Future<bool?> requestPermission() async {
    if (Platform.isIOS) {
      _requestIOSPermission();
    }
    if (Platform.isAndroid) {
      _requestAndroidPermission();
    }
    return null;
  }

  _requestIOSPermission() async {
    return await _localNotificationService
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  _requestAndroidPermission() async {
    return await _localNotificationService
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
  }

  Future<void> showNotificaion({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    return await _localNotificationService.show(id, title, body, details);
  }

  Future<void> onDidReceiveLocalNotification(
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

  Future<void> scheduleAlarmNotifications({
    required PlantModel plant,
    required bool watering,
    required bool repotting,
    required bool nutrient,
  }) async {
    String title =
        plant.information.name + (plant.alias != "" ? '(${plant.alias})' : '');
    int id = int.parse(plant.docId.hashCode.toString().substring(0, 6));
    for (AlarmModel alarm in plant.alarms) {
      String body = '';
      String channelId = alarm.id;
      String channelName = '';
      String channelDescription = '';

      if ((alarm.field == PlantField.watering && watering) ||
          (alarm.field == PlantField.repotting && repotting) ||
          (alarm.field == PlantField.nutrient && nutrient)) {
        switch (alarm.field) {
          case PlantField.watering:
            id = int.parse('1$id');
            body = '$title의 물주기 날짜입니다.';
            channelName = 'watering';
            channelDescription = '$title의 물주기 알림';

            break;
          case PlantField.repotting:
            id = int.parse('2$id');
            body = '$title의 분갈이 날짜입니다.';
            channelName = 'repotting';
            channelDescription = '$title의 분갈이 알림';

            break;
          case PlantField.nutrient:
            id = int.parse('3$id');
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
          icon: '@mipmap/ic_launcher',
        );

        DarwinNotificationDetails iOSPlatformChannelSpecifics =
            DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          subtitle: 'Your subtitle',
          categoryIdentifier: channelName,
        );

        NotificationDetails platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSPlatformChannelSpecifics,
        );

        if (alarm.isOn) {
          //알람의 초단위를 0으로초기화
          DateTime updatedStartTime = alarm.startTime
              .subtract(Duration(seconds: alarm.startTime.second));

          if (alarm.repeat == 0) {
            tz.TZDateTime scheduledDate =
                tz.TZDateTime.from(updatedStartTime, tz.local);
            if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local))) {
              await _localNotificationService.zonedSchedule(
                id,
                title,
                body,
                scheduledDate,
                platformChannelSpecifics,
                uiLocalNotificationDateInterpretation:
                    UILocalNotificationDateInterpretation.absoluteTime,
              );
            }
          } else if (alarm.repeat > 0) {
            tz.TZDateTime nextNotificationDate =
                tz.TZDateTime.from(updatedStartTime, tz.local);

            // 현재 시간 이후의 첫 번째 알림으로 설정
            while (nextNotificationDate.isBefore(tz.TZDateTime.now(tz.local))) {
              nextNotificationDate =
                  nextNotificationDate.add(Duration(days: alarm.repeat));
            }
            await scheduleRepeatingNotification(id, title, body,
                nextNotificationDate, alarm, platformChannelSpecifics);
          }
        }
      }
    }
  }

  Future<void> scheduleRepeatingNotification(
    int id,
    String title,
    String body,
    tz.TZDateTime initialDateTime,
    AlarmModel alarm,
    NotificationDetails platformChannelSpecifics,
  ) async {
    int alarmsToSchedule = 4;

    int count = 0;
    for (int i = 0; i <= alarmsToSchedule; i++) {
      tz.TZDateTime scheduledDate =
          initialDateTime.add(Duration(days: i * alarm.repeat));

      if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local)) &&
          !_isDateInOffDates(scheduledDate, alarm.offDates)) {
        int actualNotificationId = int.parse('$id${count % 100}'
            .substring(0, min(9, '$id${count % 100}'.length)));

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

  //해당 docId 를가진 plant의 notifiaction을 모두삭제한다.
  Future<void> deleteFromDocId(String docId) async {
    List<PendingNotificationRequest> pendingNotifications =
        await retrievePendingNotifications();
    final int id = int.parse(docId.hashCode.toString().substring(0, 6));
    //알람의 아이디 에서 substring(1, 7) 부분은 docId의 hashCode에 해당한다.
    for (var notification in pendingNotifications) {
      if (int.parse(notification.id.toString().substring(1, 7)) == id) {
        await _localNotificationService.cancel(notification.id);
      }
    }
  }

  Future<void> deleteFromField(PlantField field) async {
    List<PendingNotificationRequest> pendingNotifications =
        await retrievePendingNotifications();
    int code = 0;
    switch (field) {
      case PlantField.watering:
        code = 1;

        break;
      case PlantField.repotting:
        code = 2;

        break;
      case PlantField.nutrient:
        code = 3;

        break;
      case PlantField.none:
        break;
    }

    for (var notification in pendingNotifications) {
      if (notification.id.toString().startsWith('$code')) {
        await _localNotificationService.cancel(notification.id);
      }
    }
  }

  Future<void> deleteFromFieldWithDocId(PlantField field, String docId) async {
    List<PendingNotificationRequest> pendingNotifications =
        await retrievePendingNotifications();

    final int id = int.parse(docId.hashCode.toString().substring(0, 6));
    int code = 0;
    switch (field) {
      case PlantField.watering:
        code = 1;

        break;
      case PlantField.repotting:
        code = 2;

        break;
      case PlantField.nutrient:
        code = 3;

        break;
      case PlantField.none:
        break;
    }

    for (var notification in pendingNotifications) {
      if (notification.id.toString().startsWith('$code') &&
          int.parse(notification.id.toString().substring(1, 7)) == id) {
        await _localNotificationService.cancel(notification.id);
      }
    }
  }

  Future<void> deleteAll() async {
    _localNotificationService.cancelAll();
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
