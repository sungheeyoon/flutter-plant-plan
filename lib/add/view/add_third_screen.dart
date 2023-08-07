import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/widget/progress_bar.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/utils/colors.dart';

class AddThirdScreen extends ConsumerWidget {
  static String get routeName => 'addThird';
  const AddThirdScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final photoState = ref.watch(photoProvider);
    final plantState = ref.watch(addPlantProvider);

    void insertNewPlant() async {
      final user = auth.currentUser;

      if (user == null) return;

      final uid = user.uid;

      final DocumentReference docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('plants')
          .doc();

      final String docId = docRef.id;
      ref.read(addPlantProvider.notifier).updateDocId(docId);
      final String userImageUrl = await ref
          .read(photoProvider.notifier)
          .uploadPhotoAndGetUserImageUrl(uid);
      ref.read(addPlantProvider.notifier).updateUserImageUrl(userImageUrl);

      await docRef.set(ref.read(addPlantProvider).toJson());

      ref.read(photoProvider.notifier).reset();
      ref.read(alarmProvider.notifier).reset();
      ref.read(addPlantProvider.notifier).reset();
    }

    return DefaultLayout(
      title: '식물추가',
      floatingActionButton: RoundedButton(
        font: Theme.of(context).textTheme.bodyLarge,
        backgroundColor:
            plantState.information.id != "" ? pointColor2 : grayColor300,
        borderColor: plantState.information.id != ""
            ? pointColor2.withOpacity(
                0.5,
              )
            : grayColor300,
        width: 328.w,
        height: 44.h,
        textColor: Colors.white,
        name: '식물 추가 완료',
        onPressed: () async {
          if (plantState.information.id != "") {
            insertNewPlant();
            Navigator.pushNamed(context, HomeScreen.routeName);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      child: SingleChildScrollView(
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
                      if (photoState != null) //찍은애
                        Stack(children: [
                          FittedBox(
                            fit: BoxFit.contain,
                            child: CircleAvatar(
                              radius: 30.h, // Image radius
                              backgroundImage: FileImage(photoState),
                            ),
                          ),
                        ])
                      else if (plantState.information.imageUrl !=
                          "") //안찍었는데 깟다왓어
                        FittedBox(
                          fit: BoxFit.contain,
                          child: CircleAvatar(
                            radius: 30.h, // Image radius
                            backgroundImage:
                                NetworkImage(plantState.information.imageUrl),
                          ),
                        )
                      else
                        Image(
                          image: const AssetImage('assets/images/pot.png'),
                          width: 60.h,
                          height: 60.h,
                        ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (plantState.information.name != "")
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
                                plantState.information.name,
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
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: grayBlack,
                                  ),
                        ),
                      SizedBox(
                        height: 16.h,
                      ),
                      const ImmutableAlarmBox(
                        field: PlantField.watering,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      const ImmutableAlarmBox(
                        field: PlantField.repotting,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      const ImmutableAlarmBox(
                        field: PlantField.nutrient,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImmutableAlarmBox extends ConsumerWidget {
  final PlantField field;

  const ImmutableAlarmBox({
    super.key,
    required this.field,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlantModel plantState = ref.watch(addPlantProvider);

    final AlarmModel? alarmState = plantState.alarms.firstWhereOrNull(
      (alarm) => alarm.field == field,
    );
    final DateTime? lastDay = alarmState?.startTime;

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
                            lastDay != null ? dateFormatter(lastDay) : '-',
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
                              alarmState?.repeat == 0 ||
                                      alarmState?.repeat == null
                                  ? const SizedBox.shrink()
                                  : Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.h),
                                      decoration: BoxDecoration(
                                        color: pointColor1.withOpacity(0.1),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          alarmState?.repeat == 1
                                              ? '매일'
                                              : alarmState?.repeat == 7
                                                  ? '매주'
                                                  : '${alarmState?.repeat}일 마다',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                color: pointColor1,
                                              ),
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                          if (alarmState != null && alarmState.isOn)
                            Text(
                              dateFormatter(alarmState.startTime),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grayBlack,
                                  ),
                            ),
                          if (alarmState == null)
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
