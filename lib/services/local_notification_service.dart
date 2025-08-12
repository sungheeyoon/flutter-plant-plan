import 'dart:io';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOSInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const settings = InitializationSettings(
      android: androidInit,
      iOS: iOSInit,
      macOS: iOSInit,
    );

    await _localNotificationService.initialize(
      settings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const iosDetails = DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
      macOS: iosDetails,
    );
  }

  Future<bool> checkNotificationPermission() async {
    final settings =
        await _localNotificationService.getNotificationAppLaunchDetails();
    return settings?.didNotificationLaunchApp ?? false;
  }

  Future<bool?> requestPermission() async {
    if (Platform.isIOS) {
      return await _localNotificationService
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }

    if (Platform.isAndroid) {
      // Android는 flutter_local_notifications에서 권한 요청 메서드 없음
      // Android 13(API 33) 이상 알림 권한 요청이 필요하면 별도 플러그인 사용 필요
      return null;
    }

    return null;
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) async {
    // 알림 클릭 시 동작 정의
  }

  Future<void> scheduleAlarmNotifications({
    required PlantModel plant,
    required bool watering,
    required bool repotting,
    required bool nutrient,
  }) async {
    final title =
        plant.information.name + (plant.alias != "" ? '(${plant.alias})' : '');
    int id = int.parse(plant.docId.hashCode.toString().substring(0, 6));

    for (final alarm in plant.alarms) {
      if (!alarm.isOn) continue;

      String body = '';
      String channelId = alarm.id;
      String channelName = '';
      String channelDescription = '';

      switch (alarm.field) {
        case PlantField.watering:
          if (!watering) continue;
          id = int.parse('1$id');
          body = '$title의 물주기 날짜입니다.';
          channelName = 'watering';
          channelDescription = '$title의 물주기 알림';
          break;
        case PlantField.repotting:
          if (!repotting) continue;
          id = int.parse('2$id');
          body = '$title의 분갈이 날짜입니다.';
          channelName = 'repotting';
          channelDescription = '$title의 분갈이 알림';
          break;
        case PlantField.nutrient:
          if (!nutrient) continue;
          id = int.parse('3$id');
          body = '$title에게 영양제를 주는 날짜입니다.';
          channelName = 'nutrient';
          channelDescription = '$title의 영양제 알림';
          break;
        case PlantField.none:
          continue;
      }

      final platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          channelName,
          channelDescription: channelDescription,
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          subtitle: 'Your subtitle',
          categoryIdentifier: channelName,
        ),
        macOS: DarwinNotificationDetails(),
      );

      final updatedStartTime =
          alarm.startTime.subtract(Duration(seconds: alarm.startTime.second));

      final tzDate = tz.TZDateTime.from(updatedStartTime, tz.local);

      if (alarm.repeat == 0) {
        if (tzDate.isAfter(tz.TZDateTime.now(tz.local))) {
          await zonedSchedule(
            id: id,
            title: title,
            body: body,
            scheduledDate: tzDate,
            notificationDetails: platformChannelSpecifics,
          );
        }
      } else {
        var nextDate = tzDate;
        while (nextDate.isBefore(tz.TZDateTime.now(tz.local))) {
          nextDate = nextDate.add(Duration(days: alarm.repeat));
        }

        await scheduleRepeatingNotification(
          id,
          title,
          body,
          nextDate,
          alarm,
          platformChannelSpecifics,
        );
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
    const alarmsToSchedule = 4;
    int count = 0;

    for (int i = 0; i <= alarmsToSchedule; i++) {
      final scheduledDate =
          initialDateTime.add(Duration(days: i * alarm.repeat));

      if (scheduledDate.isAfter(tz.TZDateTime.now(tz.local)) &&
          !_isDateInOffDates(scheduledDate, alarm.offDates)) {
        final actualId = int.parse(
          '$id${count % 100}'.substring(0, min(9, '$id${count % 100}'.length)),
        );

        await zonedSchedule(
          id: actualId,
          title: title,
          body: body,
          scheduledDate: scheduledDate,
          notificationDetails: platformChannelSpecifics,
          payload: scheduledDate.toString(),
        );

        count++;
      }
    }
  }

  Future<void> zonedSchedule({
    required int id,
    required String? title,
    required String? body,
    required tz.TZDateTime scheduledDate,
    required NotificationDetails notificationDetails,
    String? payload,
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    await _localNotificationService.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: matchDateTimeComponents,
    );
  }

  bool _isDateInOffDates(tz.TZDateTime date, List<DateTime> offDates) {
    final localDate = date.toLocal();
    return offDates.any((offDate) =>
        offDate.year == localDate.year &&
        offDate.month == localDate.month &&
        offDate.day == localDate.day);
  }

  Future<void> deleteFromDocId(String docId) async {
    final pending = await retrievePendingNotifications();
    final id = int.parse(docId.hashCode.toString().substring(0, 6));

    for (var n in pending) {
      if (int.parse(n.id.toString().substring(1, 7)) == id) {
        await _localNotificationService.cancel(n.id);
      }
    }
  }

  Future<void> deleteFromField(PlantField field) async {
    final pending = await retrievePendingNotifications();

    final code = switch (field) {
      PlantField.watering => 1,
      PlantField.repotting => 2,
      PlantField.nutrient => 3,
      _ => 0,
    };

    for (var n in pending) {
      if (n.id.toString().startsWith('$code')) {
        await _localNotificationService.cancel(n.id);
      }
    }
  }

  Future<void> deleteFromFieldWithDocId(PlantField field, String docId) async {
    final pending = await retrievePendingNotifications();
    final id = int.parse(docId.hashCode.toString().substring(0, 6));
    final code = switch (field) {
      PlantField.watering => 1,
      PlantField.repotting => 2,
      PlantField.nutrient => 3,
      _ => 0,
    };

    for (var n in pending) {
      if (n.id.toString().startsWith('$code') &&
          int.parse(n.id.toString().substring(1, 7)) == id) {
        await _localNotificationService.cancel(n.id);
      }
    }
  }

  Future<void> deleteAll() async {
    await _localNotificationService.cancelAll();
  }

  Future<List<PendingNotificationRequest>>
      retrievePendingNotifications() async {
    try {
      return await _localNotificationService.pendingNotificationRequests();
    } catch (_) {
      return [];
    }
  }
}
