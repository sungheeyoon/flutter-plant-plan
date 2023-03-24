import 'package:flutter/material.dart';
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
  bool isSwitched = false;
  String? title;
  final DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        color: gray5Color,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: hourMinute12H(),
              ),
              const SizedBox(
                height: 32,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '반복 주기',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: primary3Color),
                      ),
                      Text(
                        '식물에게 알맞은 알림 주기를 선택해주세요',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: gray2Color),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PeriodCard(
                        number: 2,
                        text: '매일',
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      PeriodCard(
                        number: 2,
                        text: '매주',
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      PeriodCard(
                        number: 2,
                        text: '매월',
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      PeriodCard(
                        number: 3,
                        text: '직접 입력',
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        contentPadding:
                            const EdgeInsets.fromLTRB(0, 10, 10, 10),
                        enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: gray3Color)),
                        border: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: gray3Color, width: 1.0)),
                        focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: gray3Color, width: 1.0)),
                        hintText: '물주기 알림 설정 제목',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: gray2Color),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '다시 알림',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: primary3Color),
                  ),
                  Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                        });
                      },
                      activeTrackColor: primary3Color.withOpacity(0.4),
                      activeColor: primary3Color),
                ],
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
    return Container();
    // return TimePickerSpinner(
    //   is24HourMode: false,
    //   normalTextStyle: TextStyle(
    //       fontWeight: FontWeight.w400,
    //       fontSize: 32,
    //       color: primary3Color.withOpacity(0.2)),
    //   highlightedTextStyle: const TextStyle(
    //       fontWeight: FontWeight.w700, fontSize: 32, color: primary3Color),
    //   alignment: Alignment.center,
    //   spacing: 40,
    //   onTimeChange: (time) {
    //     setState(() {
    //       _dateTime = time;
    //     });
    //   },
    // );
  }
}

class PeriodCard extends StatelessWidget {
  final String text;
  final int number;
  const PeriodCard({
    super.key,
    required this.text,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: number,
      fit: FlexFit.loose,
      child: Container(
        height: 36,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            width: 1,
            color: gray3Color,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: gray2Color),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
