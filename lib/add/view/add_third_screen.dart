import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/add/provider/plant_provider.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddThirdScreen extends ConsumerWidget {
  static String get routeName => 'addThird';
  const AddThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPlant = ref.watch(selectedPlantProvider);
    final selectedPhoto = ref.watch(photoProvider);
    final plantState = ref.watch(plantInformationProvider);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 8.h,
            ),
            const ProgressBar(pageIndex: 2),
            SizedBox(
              height: 32.h,
            ),
            Center(
              child: Container(
                width: 360.w,
                padding: EdgeInsets.all(16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.h),
                  boxShadow: [
                    BoxShadow(
                      color: grayBlack.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(2, 2), // Shadow position
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (selectedPhoto != null) //찍은애
                      Stack(children: [
                        FittedBox(
                          fit: BoxFit.contain,
                          child: CircleAvatar(
                            radius: 30.h, // Image radius
                            backgroundImage: FileImage(selectedPhoto),
                          ),
                        ),
                      ])
                    else if (selectedPlant != null) //안찍었는데 깟다왓어
                      FittedBox(
                        fit: BoxFit.contain,
                        child: CircleAvatar(
                          radius: 30.h, // Image radius
                          backgroundImage: NetworkImage(selectedPlant.image),
                        ),
                      )
                    else
                      ImageBox(
                        imageUri: 'assets/images/pot.png',
                        width: 60.h,
                        height: 60.h,
                      ),
                    SizedBox(
                      height: 12.h,
                    ),
                    if (selectedPlant != null)
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.h,
                            vertical: 2.h,
                          ),
                          decoration: const BoxDecoration(
                            color: keyColor100,
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              selectedPlant.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: keyColor700,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    if (plantState.alias != "")
                      SizedBox(
                        height: 4.h,
                      ),
                    if (plantState.alias != "")
                      Text(
                        plantState.alias,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                    SizedBox(
                      height: 16.h,
                    ),
                    const ImmutableAlarmBox(
                      iconPath: 'assets/images/management/humid.png',
                      title: '물주기',
                      field: PlantField.watering,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const ImmutableAlarmBox(
                      iconPath: 'assets/images/management/repotting.png',
                      title: '분갈이',
                      field: PlantField.repotting,
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    const ImmutableAlarmBox(
                      iconPath: 'assets/images/management/nutrient.png',
                      title: '영양제',
                      field: PlantField.nutrient,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImmutableAlarmBox extends ConsumerWidget {
  final String iconPath;
  final String title;
  final PlantField field;

  const ImmutableAlarmBox({
    super.key,
    required this.iconPath,
    required this.title,
    required this.field,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlantInformationModel plantState =
        ref.watch(plantInformationProvider);
    late PlantInformationKey currentState;

    if (field == PlantField.watering) {
      currentState = plantState.watering;
    } else if (field == PlantField.repotting) {
      currentState = plantState.repotting;
    } else if (field == PlantField.nutrient) {
      currentState = plantState.nutrient;
    }
    return Center(
      child: Container(
        width: 360.w,
        padding: EdgeInsets.symmetric(
          vertical: 10.h,
          horizontal: 12.h,
        ),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconPath,
                      width: 16.h,
                      height: 16.h,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grayBlack,
                          ),
                    )
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.h,
                    horizontal: 20.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.h),
                    boxShadow: [
                      BoxShadow(
                        color: grayBlack.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 6,
                        offset: const Offset(
                          2,
                          2,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '마지막 관리 날짜',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                  color: grayColor600,
                                ),
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          Text(
                            currentState.lastDay != null
                                ? dateFormatter(
                                    currentState.lastDay as DateTime)
                                : '-',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '알림',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                      color: grayColor600,
                                    ),
                              ),
                              SizedBox(
                                width: 4.h,
                              ),
                              // if (plantState.watering.alarm
                              //         .startDay !=
                              //     null)
                              currentState.alarm.repeat == 0
                                  ? const SizedBox.shrink()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: pointColor1.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          currentState.alarm.repeat == 1
                                              ? '매일'
                                              : currentState.alarm.repeat == 7
                                                  ? '매주'
                                                  : '${currentState.alarm.repeat}일 마다',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: pointColor1,
                                              ),
                                        ),
                                      ),
                                    ),
                              // FittedBox(
                              //   fit: BoxFit.scaleDown,
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(
                              //       horizontal: 4.h,
                              //     ),
                              //     decoration: BoxDecoration(
                              //       color: pointColor2.withOpacity(0.1),
                              //       borderRadius: const BorderRadius.all(
                              //         Radius.circular(4),
                              //       ),
                              //     ),
                              //     child: Center(
                              //       child: Text(
                              //         'D-1 변경예정',
                              //         style: Theme.of(context)
                              //             .textTheme
                              //             .labelSmall!
                              //             .copyWith(
                              //               color: pointColor2,
                              //             ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          if (currentState.alarm.startDay != null)
                            Text(
                              dateFormatter(
                                  currentState.alarm.startDay as DateTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grayBlack,
                                  ),
                            ),
                          if (currentState.alarm.startDay == null)
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: grayBlack,
                                    ),
                                children: const [
                                  TextSpan(text: '-'),
                                  TextSpan(
                                    text: '333-33-33',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
