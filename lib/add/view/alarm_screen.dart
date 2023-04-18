import 'package:bubble_box/bubble_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/add/provider/date_time_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/services/notifi_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  final String title;
  const AlarmScreen({
    super.key,
    required this.title,
  });

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
  late final LocalNotificationService service;
  bool isSwitched = false;
  bool showBubbleBox = false;
  String? name;
  int focusedButtonIndex = -1;
  String? nextAlarmText;

  @override
  void initState() {
    service = LocalNotificationService();
    service.initialize();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = ref.watch(dateTimeProvider);
    return DefaultLayout(
      title: '${widget.title} 알림',
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
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
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showBubbleBox = true;
                              });

                              Future.delayed(
                                const Duration(seconds: 3),
                                () {
                                  setState(
                                    () {
                                      showBubbleBox = false;
                                    },
                                  );
                                },
                              );
                            },
                            child: const CircleAvatar(
                              radius: 8.0,
                              backgroundColor: pointColor2,
                              child: CircleAvatar(
                                radius: 7.0,
                                backgroundColor: Colors.white,
                                child: Text(
                                  '?',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.w600,
                                    color: pointColor2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (showBubbleBox)
                            BubbleBox(
                              maxWidth: 204,
                              shape: BubbleShapeBorder(
                                direction: BubbleDirection.left,
                                radius: const BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                position: const BubblePosition.start(20),
                                arrowQuadraticBezierLength: 2,
                              ),
                              backgroundColor: grayColor600,
                              margin: const EdgeInsets.all(4),
                              child: Text(
                                '이전 정보추가 페이지에서 날짜를 지정한 경우 자동으로 반영돼요',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.white),
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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PeriodButton(
                            flex: 2,
                            text: '매일',
                            isFocused: focusedButtonIndex == 0,
                            onTapCallback: () => _updateFocusedButton(0),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          PeriodButton(
                            flex: 2,
                            text: '매주',
                            isFocused: focusedButtonIndex == 1,
                            onTapCallback: () => _updateFocusedButton(1),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          PeriodButton(
                            flex: 2,
                            text: '매월',
                            isFocused: focusedButtonIndex == 2,
                            onTapCallback: () => _updateFocusedButton(2),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          PeriodButton(
                            flex: 3,
                            text: '직접 입력',
                            isFocused: focusedButtonIndex == 3,
                            onTapCallback: () => _updateFocusedButton(3),
                          ),
                        ],
                      )
                    ],
                  ),
                  Text('$nextAlarmText'),
                  Text('$dateTime'),
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
                      debugPrint('Notification Scheduled for $dateTime');
                      NotificationService().scheduleNotification(
                          title: 'Scheduled Notification',
                          body: '$dateTime',
                          scheduledNotificationDateTime: dateTime);
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

  void _updateFocusedButton(int index, {int? days}) {
    final dateTime = ref.watch(dateTimeProvider);
    DateTime dateTime0 = dateTime;
    setState(
      () {
        if (focusedButtonIndex == index) {
          // If the same card is tapped again, unfocus it
          focusedButtonIndex = -1;
        } else {
          focusedButtonIndex = index;

          switch (index) {
            case 0: // '매일' 버튼
              dateTime0 = dateTime.add(
                const Duration(days: 1),
              );
              break;
            case 1: // '매주' 버튼
              dateTime0 = dateTime.add(
                const Duration(days: 7),
              );
              break;
            case 2: // '매월' 버튼
              int year = dateTime.year;
              int month = dateTime.month + 1;
              int day = dateTime.day;
              int hour = dateTime.hour;
              int minute = dateTime.minute;
              if (month > 12) {
                year += 1;
                month = 1;
              }
              int lastDayOfMonth = DateTime(year, month + 1, 0).day;
              day = day <= lastDayOfMonth ? day : lastDayOfMonth;
              dateTime0 = DateTime(year, month, day, hour, minute);
              break;
            case 3: // '직접 입력' 버튼
              if (days != null) {
                dateTime0 = dateTime.add(
                  Duration(days: days),
                );
              } else {
                // days가 null인 경우에는 _dateTime을 업데이트하지 않고 기존 값을 유지함
              }
              break;
          }
        }

        // 다음 날짜와 시간 포맷
        // 다음 날짜와 시간 포맷
        String nextDate = "${dateTime.month}월 ${dateTime.day}일";
        String nextTime = "${dateTime.hour}시 ${dateTime.minute}분";

        // 다음 알림 텍스트 업데이트
        nextAlarmText = "다음 알림은 $nextDate $nextTime 입니다.";
      },
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
              ref.read(dateTimeProvider.notifier).setDateTime(time);
            },
          );
        },
      ),
    );
  }
}

class PeriodButton extends StatelessWidget {
  final String text;
  final int flex;
  final bool isFocused;
  final VoidCallback onTapCallback;
  const PeriodButton({
    super.key,
    required this.text,
    required this.flex,
    required this.isFocused,
    required this.onTapCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: flex,
      fit: FlexFit.loose,
      child: GestureDetector(
        onTap: onTapCallback,
        child: Container(
          height: 36,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            color: isFocused ? pointColor1 : Colors.white,
            border: Border.all(
              width: 1,
              color: isFocused ? pointColor1 : grayColor400,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: isFocused ? Colors.white : grayColor500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
