import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/widget/date_picker_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/utils/colors.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addAlarm';
  final String title;
  final PlantField field;
  final Alarm? alarm;

  const AlarmScreen({
    super.key,
    required this.title,
    required this.field,
    required this.alarm,
  });

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
  late final LocalNotificationService service;
  bool isSwitched = false;
  late PlantField selectedField;
  int focusedButtonIndex = -1;
  String? nextAlarmText;
  late String lastDayText;
  late DateTime? lastDay;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // final PlantInformationModel plantState = ref.read(plantInformationProvider);
    //물준날, 분갈이, 영양제에 따른 페이지 초기화

    if (widget.alarm != null) {
      ref.read(alarmProvider.notifier).setAlarm(widget.alarm);
    } else {
      ref.read(alarmProvider.notifier).setField(widget.field);
    }
    textController.text = widget.alarm?.title ?? "";

    final PlantInformationModel plantState = ref.read(plantInformationProvider);
    if (widget.field == PlantField.watering) {
      lastDayText = '마지막으로 물 준 날';
      lastDay = plantState.watringLastDay;
      // Delay the modification using Future.delayed
      // Future.delayed(Duration.zero, () {
      //   ref.read(alarmProvider.notifier).setAlarm(plantState.watering.alarm);
      // });
    } else if (widget.field == PlantField.repotting) {
      lastDayText = '마지막으로 분갈이 한 날';
      lastDay = plantState.repottingLastDay;

      // Delay the modification using Future.delayed
      // Future.delayed(Duration.zero, () {
      //   ref.read(alarmProvider.notifier).setAlarm(plantState.repotting.alarm);
      // });
    } else if (widget.field == PlantField.nutrient) {
      lastDayText = '마지막으로 영양제 준 날';
      lastDay = plantState.nutrientLastDay;

      // Delay the modification using Future.delayed
      // Future.delayed(Duration.zero, () {
      //   ref.read(alarmProvider.notifier).setAlarm(plantState.nutrient.alarm);
      // });
    }
    //반복주기 버튼활성
    if (widget.alarm?.repeat == 0) {
      focusedButtonIndex = -1;
    } else if (widget.alarm?.repeat == 1) {
      focusedButtonIndex = 0;
    } else if (widget.alarm?.repeat == 7) {
      focusedButtonIndex = 1;
    } else {
      focusedButtonIndex = 3;
    }
  }

  @override
  void dispose() {
    // TextEditingController 해제
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Alarm alarmState = ref.watch(alarmProvider);

    DateTime nextAlarmDate =
        alarmState.startTime.add(Duration(days: alarmState.repeat));
    return DefaultLayout(
      textbutton: TextButton(
        onPressed: () {
          if (alarmState.isOn) {
            ref
                .read(plantInformationProvider.notifier)
                .updateAlarm(alarmState.id, alarmState);

            Navigator.pop(context);
          } else {
            return;
          }
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.only(right: 5.w),
          disabledForegroundColor: const Color(0xFF999999).withOpacity(0.38),
        ),
        child: Text(
          '완료',
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: !alarmState.isOn
                    ? const Color(0xFF999999).withOpacity(0.38)
                    : pointColor2,
              ),
        ),
      ),
      title: '${widget.title} 알림',
      child: SafeArea(
        child: SingleChildScrollView(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      lastDayText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: primaryColor),
                    ),
                    Text(
                      lastDay != null ? dateFormatter(lastDay!) : '-',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: grayBlack),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '알림 시작일',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: primaryColor),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                  ],
                ),
                DatePickerWidget(
                  field: widget.field,
                  hintText: '날짜를 설정해주세요',
                  alarm: true,
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
                          onTapCallback: () => {
                            setState(
                              () {
                                ref.read(alarmProvider.notifier).setRepeat(1);
                                _updateFocusedButton(0);
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        PeriodButton(
                          flex: 2,
                          text: '매주',
                          isFocused: focusedButtonIndex == 1,
                          onTapCallback: () => {
                            setState(
                              () {
                                ref.read(alarmProvider.notifier).setRepeat(7);

                                _updateFocusedButton(1);
                              },
                            )
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        PeriodButton(
                          flex: 2,
                          text: '직접 입력',
                          isFocused: focusedButtonIndex == 3,
                          onTapCallback: () => _updateFocusedButton(3),
                        ),
                      ],
                    )
                  ],
                ),
                if (focusedButtonIndex == 3)
                  Column(
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9]'),
                          ), // Only allow digits
                          FilteringTextInputFormatter.deny(
                            RegExp(r'-'),
                          ), // Deny negative sign
                        ],
                        onChanged: (text) {
                          setState(
                            () {
                              int? intValue =
                                  int.tryParse(text); // String을 int로 변환
                              if (intValue != null) {
                                // intValue가 null이 아닌 경우에만 값을 업데이트

                                ref
                                    .read(alarmProvider.notifier)
                                    .setRepeat(intValue);
                              }
                            },
                          );
                        },
                        textAlignVertical: TextAlignVertical.center,
                        textAlign: TextAlign.start,
                        initialValue: alarmState.repeat.toString(),
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
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixText: '일 마다',
                          suffixStyle: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: grayColor600),
                        ),
                      ),
                    ],
                  ),

                if (alarmState.isOn && focusedButtonIndex != -1)
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          nextAlarmFomattor(nextAlarmDate),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: pointColor1),
                        )
                      ],
                    ),
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
                      child: Column(
                        children: [
                          TextFormField(
                            controller: textController,
                            onChanged: (text) {
                              ref.read(alarmProvider.notifier).setTitle(text);
                            },
                            textAlignVertical: TextAlignVertical.center,
                            textAlign: TextAlign.start,
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
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Text(
                //       '다시 알림',
                //       style: Theme.of(context)
                //           .textTheme
                //           .labelLarge!
                //           .copyWith(color: primaryColor),
                //     ),
                //     Switch(
                //         value: isSwitched,
                //         onChanged: (value) {
                //           setState(() {
                //             isSwitched = value;
                //           });
                //         },
                //         activeTrackColor: primaryColor.withOpacity(0.4),
                //         activeColor: primaryColor),
                //   ],
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     // await NotificationService().showNotification(
                //     //     id: 0, title: 'what', body: "asdasd", payLoad: "asdasd");
                //     debugPrint('Notification Scheduled for $dateTime');
                //     NotificationService().scheduleNotification(
                //         title: 'Scheduled Notification',
                //         body: '$dateTime',
                //         scheduledNotificationDateTime:
                //             dateTime[DateTimeKey.now]!);
                //   },
                //   child: const Text('Scheduled Notification'),
                // ),
                // ElevatedButton(
                //   onPressed: () async {
                //     debugPrint('cancel Notification Scheduled');
                //     NotificationService().cancel(0);
                //   },
                //   child: const Text('cancel Notification'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateFocusedButton(int index) {
    // final Alarm alarmState = ref.watch(alarmProvider);
    setState(
      () {
        if (focusedButtonIndex == index) {
          focusedButtonIndex = -1;
          // ref
          //     .read(alarmProvider.notifier)
          //     .setDateTimeNull(AlarmDateTimeField.nextAlarm);
        } else {
          focusedButtonIndex = index;
          // ref
          //     .read(alarmProvider.notifier)
          //     .updateNextAlarmTime(days: alarmState.repeat);
        }
      },
    );
  }

  Widget hourMinute12H() {
    final Alarm alarmState = ref.watch(alarmProvider);
    return Container(
      width: 360.w,
      height: 194.h,
      decoration: BoxDecoration(
        color: pointColor2.withOpacity(0.04),
        borderRadius: BorderRadius.circular(16),
      ),
      child: TimePickerSpinner(
        time: alarmState.isOn ? alarmState.startTime : DateTime.now(),
        is24HourMode: false,
        normalTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 28.sp,
          color: pointColor2.withOpacity(0.25),
        ),
        itemWidth: 45,
        isForce2Digits: true,
        highlightedTextStyle: TextStyle(
            fontWeight: FontWeight.w700, fontSize: 30.sp, color: pointColor2),
        alignment: Alignment.center,
        spacing: 44.w,
        onTimeChange: (time) async {
          ref
              .read(alarmProvider.notifier)
              .setStartTime(StartTimeOption.time, time);
          // setState(
          //   () {
          //     ref
          //         .read(alarmProvider.notifier)
          //         .updateNextAlarmTime(days: alarmState.repeat);
          //   },
          // );
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
