import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/services/notifi_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late final LocalNotificationService service;
  String? title;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: '알림 설정',
        home: false,
        bgColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: gray5Color,
        child: Column(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          hourMinute12H(),
          const SizedBox(
            height: 22,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 81,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '제목',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(color: primary3Color),
              ),
              SizedBox(
                height: 40,
                child: TextFormField(
                  onChanged: (text) {
                    setState(() {
                      title = text;
                    });
                  },
                  textAlign: TextAlign.start,
                  initialValue: title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: grayBlack),
                  decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(width: 1, color: gray3Color)),
                      border: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: gray3Color, width: 1.0)),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: gray3Color, width: 1.0)),
                      hintText: '선택사항',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: gray2Color)),
                ),
              ),
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            height: 72,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '알람 주기',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: primary3Color),
                  ),
                  Text(
                    '다음 알람은 000000000',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: gray2Color),
                  )
                ],
              )
            ]),
          ),
          ElevatedButton(
            onPressed: () async {
              // await NotificationService().showNotification(
              //     id: 0, title: 'what', body: "asdasd", payLoad: "asdasd");
              debugPrint('Notification Scheduled for $_dateTime');
              NotificationService().scheduleNotification(
                  title: 'Scheduled Notification',
                  body: '$_dateTime',
                  scheduledNotificationDateTime: _dateTime);
            },
            child: const Text('Scheduled Notification'),
          ),
          ElevatedButton(
            onPressed: () async {
              debugPrint('cancel Notification Scheduled');
              NotificationService().cancel(0);
            },
            child: const Text('cancel Notification'),
          ),
        ]),
      ),
    );
  }

  Widget hourMinute12H() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          color: primary3Color.withOpacity(0.2)),
      highlightedTextStyle: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 32, color: primary3Color),
      alignment: Alignment.center,
      spacing: 40,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
