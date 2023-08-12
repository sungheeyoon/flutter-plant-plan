import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/alarm_screen.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/utils/colors.dart';

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
    final PlantModel plantState = ref.watch(addPlantProvider);
    final PlantModel? datailState = ref.watch(detailProvider);

    final List<AlarmModel>? alarms =
        isDetail ? datailState?.alarms : plantState.alarms;

    final AlarmModel? alarmState =
        alarms?.firstWhereOrNull((alarm) => alarm.field == field);

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

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AlarmScreen(
              title: title,
              field: field,
              alarm: alarmState,
            ),
          ),
        );
      },
      child: Center(
        child: Container(
          width: 360.w,
          padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
          decoration: BoxDecoration(
            color: grayColor100,
            borderRadius: BorderRadius.circular(16.h),
            border: Border.all(
              width: 1.h,
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
                        width: 20.h,
                        height: 20.h,
                      ),
                      SizedBox(
                        width: 4.h,
                      ),
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayBlack,
                            ),
                      )
                    ],
                  ),
                  if (alarmState == null)
                    CircleAvatar(
                      radius: 8.h,
                      backgroundColor: pointColor2,
                      child: const Icon(
                        Icons.add, // 플러스 아이콘
                        size: 16, // 아이콘 크기 설정
                        color: Colors.white, // 아이콘 색상 설정
                      ),
                    ),
                  if (alarmState != null && isDetail)
                    SizedBox(
                      width: 50,
                      height: 20,
                      child: Switch(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: alarmState.isOn,
                        onChanged: (value) {},
                        activeTrackColor: primaryColor.withOpacity(0.4),
                        activeColor: primaryColor,
                      ),
                    ),
                ],
              ),
              if (alarmState != null && alarmState.isOn)
                Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 360.w,
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 16.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.h),
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
                                        horizontal: 4.h,
                                        vertical: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: pointColor1.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(
                                            4), // border radius 설정
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
                              ref
                                  .read(addPlantProvider.notifier)
                                  .alarmDelete(alarmState.id);
                            },
                            child: Image.asset(
                              'assets/icons/trash.png',
                              width: 18.h,
                              height: 18.h,
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