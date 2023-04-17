import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/services/notifi_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AlarmScreen extends StatefulWidget {
  final String title;
  const AlarmScreen({
    super.key,
    required this.title,
  });

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  late final LocalNotificationService service;
  bool isSwitched = false;
  String? name;
  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '${widget.title} 알림',
      child: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 12.h,
                  ),
                  hourMinute12H(),
                  SizedBox(
                    height: 28.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '시작 날짜',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: primaryColor),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Tooltip(
                            richMessage: TextSpan(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                              children: const [
                                TextSpan(text: '이전 정보추가 페이지에서 날짜를'),
                                WidgetSpan(
                                  child: SizedBox(
                                    height: 19.0,
                                  ), // 간격 조정을 위한 SizedBox 추가
                                ),
                                TextSpan(text: '지정한 경우 자동으로 반영돼요'),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 8.h,
                              backgroundColor: pointColor2,
                              child: CircleAvatar(
                                radius: 7.h,
                                backgroundColor: Colors.white,
                                child: Center(
                                  child: Text(
                                    '?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.h,
                                      fontWeight: FontWeight.w600,
                                      color: pointColor2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        height: 42.h,
                        child: TextFormField(
                          onChanged: (text) {
                            setState(
                              () {
                                name = text;
                              },
                            );
                          },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          initialValue: name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: grayBlack),
                          decoration: InputDecoration(
                            suffixIcon: const Padding(
                              padding: EdgeInsets.only(right: 10.0),
                              child: ImageBox(
                                imageUri: 'assets/icons/calendar_box.png',
                                width: 20,
                                height: 20,
                              ),
                            ),
                            suffixIconConstraints: BoxConstraints(
                              minHeight: 20.h,
                              minWidth: 20.h,
                            ),
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(16, 10.h, 16, 10.h),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(width: 1, color: grayColor400),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(color: grayColor400, width: 1.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(color: grayColor400, width: 1.0),
                            ),
                            hintText: '나만의 알림 제목을 설정해보세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: grayColor400),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '반복 주기',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: primaryColor),
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
                            width: 8,
                          ),
                          PeriodCard(
                            number: 2,
                            text: '매주',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          PeriodCard(
                            number: 2,
                            text: '매월',
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          PeriodCard(
                            number: 3,
                            text: '직접 입력',
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 16.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '제목',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: primaryColor),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        height: 42.h,
                        child: TextFormField(
                          onChanged: (text) {
                            setState(
                              () {
                                name = text;
                              },
                            );
                          },
                          textAlignVertical: TextAlignVertical.center,
                          textAlign: TextAlign.start,
                          initialValue: name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: grayBlack),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding:
                                EdgeInsets.fromLTRB(16, 10.h, 16, 10.h),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(width: 1, color: grayColor400),
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(color: grayColor400, width: 1.0),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(
                                  8.0,
                                ),
                              ),
                              borderSide:
                                  BorderSide(color: grayColor400, width: 1.0),
                            ),
                            hintText: '나만의 알림 제목을 설정해보세요',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: grayColor400),
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
                            .copyWith(color: primaryColor),
                      ),
                      Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                          activeTrackColor: primaryColor.withOpacity(0.4),
                          activeColor: primaryColor),
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
        ),
      ),
    );
  }

  Widget hourMinute12H() {
    return Container(
      width: 360.w,
      height: 194.h,
      decoration: BoxDecoration(
        color: pointColor2.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TimePickerSpinner(
        is24HourMode: false,
        normalTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 28.h,
          color: pointColor2.withOpacity(0.25),
        ),
        itemWidth: 45,
        isForce2Digits: true,
        highlightedTextStyle: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 32.h, color: pointColor2),
        alignment: Alignment.center,
        spacing: 44.w,
        onTimeChange: (time) {
          setState(
            () {
              _dateTime = time;
            },
          );
        },
      ),
    );
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
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          border: Border.all(
            width: 1,
            color: grayColor400,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: grayColor500),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
