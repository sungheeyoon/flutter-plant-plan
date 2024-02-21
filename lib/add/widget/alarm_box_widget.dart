import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/alarm_screen.dart';
import 'package:plant_plan/common/provider/alarm_setting_provider.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/list/model/detail_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';
import 'package:plant_plan/services/local_notification_service.dart';

class AlarmBoxWidget extends ConsumerWidget {
  final PlantField field;
  final bool isDetail;

  const AlarmBoxWidget({
    super.key,
    required this.field,
    required this.isDetail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlantModel addPlantState = ref.watch(addPlantProvider);
    DetailModel? detailState;

    if (isDetail) {
      detailState = ref.watch(detailProvider) as DetailModel;
    } else {
      // isDetail이 false일 때에는 DetailModelLoading 상태 처리
      final detailStateValue = ref.watch(detailProvider);
      if (detailStateValue is DetailModel) {
        detailState = detailStateValue;
      } else if (detailStateValue is DetailModelLoading) {
        // DetailModelLoading 상태 처리
      }
    }

    final List<AlarmModel> alarms =
        isDetail ? detailState?.data.alarms ?? [] : addPlantState.alarms;

    final AlarmModel? alarmState =
        alarms.firstWhereOrNull((alarm) => alarm.field == field);
    //현재날짜
    final DateTime now = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    //가장최근 알람확인일
    DateTime? earliestDate =
        alarmState is AlarmModel ? findEarliestDate(alarmState.offDates) : null;

    late String iconPath;
    late String title;

    if (field == PlantField.watering) {
      iconPath = 'assets/images/management/humid.png';
      title = '물주기';
    } else if (field == PlantField.repotting) {
      iconPath = 'assets/images/management/repotting.png';
      title = '분갈이';
    } else if (field == PlantField.nutrient) {
      iconPath = 'assets/images/management/nutrient.png';
      title = '영양제';
    }

    Future<void> updateNotification(bool value) async {
      if (isDetail) {
        LocalNotificationService notificationService =
            LocalNotificationService();

        bool watering = ref.read(wateringProvider);
        bool repotting = ref.read(repottingProvider);
        bool nutrient = ref.read(nutrientProvider);

        if (field == PlantField.watering && watering) {
          repotting = false;
          nutrient = false;
        } else if (field == PlantField.repotting && repotting) {
          watering = false;
          nutrient = false;
        } else if (field == PlantField.nutrient && nutrient) {
          watering = false;
          repotting = false;
        } else {
          watering = false;
          repotting = false;
          nutrient = false;
        }

        final plant = detailState!.data;

        if (value) {
          //알림추가
          await notificationService.scheduleAlarmNotifications(
            plant: plant,
            watering: watering,
            repotting: repotting,
            nutrient: nutrient,
          );
        } else {
          //알림삭제
          await notificationService.deleteFromFieldWithDocId(
              field, plant.docId);
        }
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmScreen(
              field: field,
              alarm: alarmState,
              isDetail: isDetail,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 360.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: grayColor100,
            borderRadius: BorderRadius.circular(16.w),
            border: Border.all(
              width: 1.w,
              color: grayColor300,
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        iconPath,
                        width: 20.w,
                        height: 20.w,
                      ),
                      SizedBox(
                        width: 4.w,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      if (isDetail)
                        buildDateDifferenceWidget(earliestDate, now, context),
                    ],
                  ),
                  if (alarmState == null)
                    CircleAvatar(
                      radius: 8.w,
                      backgroundColor: pointColor2,
                      child: Icon(
                        Icons.add, // 플러스 아이콘
                        size: 16.w, // 아이콘 크기 설정
                        color: Colors.white, // 아이콘 색상 설정
                      ),
                    ),
                  if (alarmState != null && isDetail)
                    SizedBox(
                      width: 40.w,
                      height: 25.2.w,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: CupertinoSwitch(
                          value: alarmState.isOn,
                          onChanged: (value) async {
                            ref
                                .read(detailProvider.notifier)
                                .toggleIsOnAlarm(alarmState.id);
                            await ref.read(plantsProvider.notifier).updateAlarm(
                                alarmState.id, detailState!.data.docId,
                                isOnToggle: true);
                            updateNotification(value);
                          },
                          trackColor: grayColor400,
                          activeColor: pointColor2,
                        ),
                      ),
                    ),
                ],
              ),
              if (alarmState != null)
                Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 360.w,
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.w),
                        boxShadow: [
                          BoxShadow(
                            color: grayBlack.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: const Offset(
                                2, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              alarmState.repeat == 0
                                  ? const SizedBox.shrink()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.w,
                                      ),
                                      decoration: BoxDecoration(
                                        color: pointColor1.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                          4.w,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          alarmState.repeat == 1
                                              ? '매일'
                                              : alarmState.repeat == 7
                                                  ? '매주'
                                                  : '${alarmState.repeat}일 마다',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: pointColor1,
                                              ),
                                        ),
                                      ),
                                    ),
                              if (alarmState.repeat != 0)
                                SizedBox(
                                  height: 8.h,
                                ),
                              Visibility(
                                visible: alarmState.title.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      alarmState.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: primaryColor),
                                    ),
                                    SizedBox(height: 2.h),
                                  ],
                                ),
                              ),
                              Text(
                                DateFormat('h : mm a')
                                    .format(alarmState.startTime),
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                      color: primaryColor,
                                    ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (isDetail) {
                                ref
                                    .read(detailProvider.notifier)
                                    .deleteAlarm(alarmState.id);
                                ref.read(plantsProvider.notifier).deleteAlarm(
                                    alarmState.id, detailState!.data.docId);
                                LocalNotificationService()
                                    .deleteFromFieldWithDocId(
                                        field, detailState.data.docId);
                              } else {
                                ref
                                    .read(addPlantProvider.notifier)
                                    .deleteAlarm(alarmState.id);
                              }
                            },
                            child: Image.asset(
                              'assets/icons/trash.png',
                              width: 18.w,
                              height: 18.w,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Container buildDateDifferenceWidget(
    DateTime? earliestDate, DateTime now, BuildContext context) {
  if (earliestDate is DateTime) {
    final differenceInDays = calculateDateDifferenceInDays(earliestDate, now);
    final displayText = differenceInDays == 0 ? '오늘' : '$differenceInDays일 전';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: grayColor300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          displayText,
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: grayColor600,
              ),
        ),
      ),
    );
  } else {
    return Container();
  }
}
