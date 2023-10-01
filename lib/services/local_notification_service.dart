import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
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

  Future<void> scheduleAlarmNotification(AlarmModel alarm) async {
    // 타이틀과 바디 채널 설정
    String title = '';
    String body = '';
    String channelId = alarm.id;
    String channelName = '';
    String channelDescription = '';

    switch (alarm.field) {
      case PlantField.watering:
        title = '물주기 알림';
        body = '오늘은 ${alarm.title}의 물주기 날짜입니다.';
        channelName = 'watering';
        channelDescription = '해당 식물의 $title';
        break;
      case PlantField.repotting:
        title = '분갈이 알림';
        body = '오늘은 ${alarm.title}의 분갈이 날짜입니다.';
        channelName = 'repotting';
        channelDescription = '해당 식물의 $title';
        break;
      case PlantField.nutrient:
        title = '영양제 알림';
        body = '오늘은 ${alarm.title}에게 영양제를 주는 날짜입니다.';
        channelName = 'nutrient';
        channelDescription = '해당 식물의 $title';
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

    // 현재 시간부터 첫 번째 알림을 예약
    await _localNotificationService.zonedSchedule(
      alarm.id.hashCode, // 아이디를 사용하여 유니크한 알림 ID 생성
      title,
      body,
      tz.TZDateTime.from(alarm.startTime, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'item x',
    );

    // 추가적인 반복 알림 예약
    if (alarm.repeat > 0) {
      tz.TZDateTime nextNotificationDate = tz.TZDateTime.from(
          alarm.startTime.add(Duration(days: alarm.repeat)), tz.local);

      // 현재 시간 이후의 첫 번째 알림으로 설정
      while (nextNotificationDate.isBefore(tz.TZDateTime.now(tz.local))) {
        nextNotificationDate =
            nextNotificationDate.add(Duration(days: alarm.repeat));
      }

      // 반복 알림 예약
      await _localNotificationService.zonedSchedule(
        alarm.id.hashCode + alarm.repeat, // 아이디를 사용하여 유니크한 알림 ID 생성
        title,
        body,
        nextNotificationDate,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'item x',
      );
    }
  }
}
