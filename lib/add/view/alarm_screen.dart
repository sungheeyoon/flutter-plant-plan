import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/widget/date_picker_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/alarm_setting_provider.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/list/model/detail_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/services/local_notification_service.dart';

import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';

class AlarmScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addAlarm';
  final PlantField field;
  final bool isDetail;
  final AlarmModel? alarm;

  const AlarmScreen({
    super.key,
    required this.field,
    required this.alarm,
    required this.isDetail,
  });

  @override
  ConsumerState<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends ConsumerState<AlarmScreen> {
  late String title;
  late PlantField selectedField;
  int focusedButtonIndex = -1;
  String? nextAlarmText;
  late String lastDayText;
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (widget.alarm != null) {
        ref.read(alarmProvider.notifier).setAlarm(widget.alarm);
      } else {
        ref.read(alarmProvider.notifier).setFieldAndReset(widget.field);
      }
    });
    textController.text = widget.alarm?.title ?? "";

    if (widget.field == PlantField.watering) {
      lastDayText = '마지막으로 물 준 날';
      title = '물주기';
    } else if (widget.field == PlantField.repotting) {
      lastDayText = '마지막으로 분갈이 한 날';
      title = '분갈이';
    } else if (widget.field == PlantField.nutrient) {
      lastDayText = '마지막으로 영양제 준 날';
      title = '영양제';
    }
    //반복주기 버튼활성
    if (widget.alarm?.repeat == null || widget.alarm?.repeat == 0) {
      focusedButtonIndex = -1;
    } else if (widget.alarm?.repeat == 1) {
      focusedButtonIndex = 0;
    } else if (widget.alarm?.repeat == 7) {
      focusedButtonIndex = 1;
    } else {
      focusedButtonIndex = 3;
    }
  }

  Future<void> updateNotification() async {
    if (widget.isDetail) {
      final detailState = ref.read(detailProvider) as DetailModel;
      LocalNotificationService notificationService = LocalNotificationService();

      bool watering = ref.read(wateringProvider);
      bool repotting = ref.read(repottingProvider);
      bool nutrient = ref.read(nutrientProvider);

      if (widget.field == PlantField.watering && watering) {
        repotting = false;
        nutrient = false;
      } else if (widget.field == PlantField.repotting && repotting) {
        watering = false;
        nutrient = false;
      } else if (widget.field == PlantField.nutrient && nutrient) {
        watering = false;
        repotting = false;
      } else {
        watering = false;
        repotting = false;
        nutrient = false;
      }

      final plant = detailState.data;

      //수정된 알림 우선삭제
      await notificationService.deleteFromFieldWithDocId(
          widget.field, plant.docId);
      //수정된 알림  업데이트
      await notificationService.scheduleAlarmNotifications(
        plant: plant,
        watering: watering,
        repotting: repotting,
        nutrient: nutrient,
      );
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AlarmModel alarmState = ref.watch(alarmProvider);
    DateTime nextAlarmDate =
        alarmState.startTime.add(Duration(days: alarmState.repeat));
    return DefaultLayout(
      actions: [
        TextButton(
          onPressed: () async {
            if (focusedButtonIndex != -1 && alarmState.repeat != 0) {
              if (widget.isDetail) {
                final detailState = ref.read(detailProvider) as DetailModel;
                ref
                    .read(detailProvider.notifier)
                    .updateAlarm(alarmState.id, alarmState);
                await ref.read(plantsProvider.notifier).updateOrAddAlarm(
                    alarmState.id, detailState.data.docId, alarmState);
                updateNotification();
                if (!mounted) return;
                Navigator.pop(context);
              } else {
                ref
                    .read(addPlantProvider.notifier)
                    .updateAlarm(alarmState.id, alarmState);
                Navigator.pop(context);
              }
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
                  color: focusedButtonIndex != -1 && alarmState.repeat != 0
                      ? pointColor2
                      : const Color(0xFF999999).withOpacity(0.38),
                ),
          ),
        )
      ],
      title: '$title 알림',
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
                hourMinute12H(time: widget.alarm?.startTime ?? DateTime.now()),
                SizedBox(
                  height: 28.h,
                ),
                Text(
                  lastDayText,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: primaryColor),
                ),
                SizedBox(
                  height: 8.h,
                ),
                DatePickerWidget(
                  field: widget.field,
                  hintText: '날짜를 설정해주세요',
                ),
                SizedBox(
                  height: 16.h,
                ),
                const Divider(
                  color: grayColor200,
                  thickness: 1,
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  '반복 주기',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: primaryColor),
                ),
                SizedBox(
                  height: 12.h,
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
                    SizedBox(
                      width: 8.w,
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
                    SizedBox(
                      width: 8.w,
                    ),
                    PeriodButton(
                      flex: 2,
                      text: '직접 입력',
                      isFocused: focusedButtonIndex == 3,
                      onTapCallback: () => _updateFocusedButton(3),
                    ),
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
                if (focusedButtonIndex != -1)
                  Column(
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
                SizedBox(
                  height: 16.h,
                ),
                const Divider(
                  color: grayColor200,
                  thickness: 1,
                ),
                SizedBox(
                  height: 16.h,
                ),
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
                TextFormField(
                  maxLength: 20,
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
                    contentPadding: EdgeInsets.fromLTRB(16, 10.h, 0, 10.h),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                      borderSide: BorderSide(width: 1, color: grayColor400),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                      borderSide: BorderSide(color: grayColor400, width: 1.0),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          8.0,
                        ),
                      ),
                      borderSide: BorderSide(color: grayColor400, width: 1.0),
                    ),
                    hintText: '나만의 알림 제목을 설정해보세요',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayColor400),
                    counterStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: grayColor600),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _updateFocusedButton(int index) {
    setState(
      () {
        if (focusedButtonIndex == index) {
          focusedButtonIndex = -1;
        } else {
          focusedButtonIndex = index;
        }
      },
    );
  }

  Widget hourMinute12H({required DateTime time}) {
    return Center(
      child: Container(
        width: 312.w,
        height: 196.w,
        decoration: BoxDecoration(
          color: pointColor2.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
        ),
        child: TimePickerSpinner(
          time: time,
          is24HourMode: false,
          normalTextStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 26.sp,
            color: pointColor2.withOpacity(0.25),
          ),
          itemWidth: 45.w,
          isForce2Digits: true,
          highlightedTextStyle: TextStyle(
              fontWeight: FontWeight.w700, fontSize: 28.sp, color: pointColor2),
          alignment: Alignment.center,
          spacing: 54.w,
          onTimeChange: (time) async {
            ref
                .read(alarmProvider.notifier)
                .setStartTime(StartTimeOption.time, time);
          },
        ),
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
