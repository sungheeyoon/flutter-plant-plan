import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/information_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';
import 'package:uuid/uuid.dart';

class AddSecondScreen extends ConsumerWidget {
  static String get routeName => 'addSecond';
  final bool fromDirect;
  const AddSecondScreen({
    super.key,
    this.fromDirect = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final photoState = ref.watch(photoProvider);
    final plantState = ref.watch(addPlantProvider);
    final InformationModel informationState = ref.watch(informationProvider);

    bool isTapHandled = false;

    void showLoadingDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.black.withOpacity(0.5),
            insetPadding: EdgeInsets.zero,
            shape:
                const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
            child: const SizedBox(
              width: 1000,
              height: 1000,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          );
        },
      );
    }

    Future<void> insertNewPlant() async {
      try {
        Map<String, dynamic> data;
        final user = auth.currentUser;

        // 사용자가 없으면 종료
        if (user == null) return;

        final uid = user.uid;

        // uid 를 document 이름에 넣음으로써 해당 doc에 하나의 유저 식물정보들만 모음
        final docRef = FirebaseFirestore.instance
            .collection('users')
            .doc(uid)
            .collection('plants')
            .doc();
        final docId = docRef.id;

        // Provider notifiers를 사용하여 docId 및 userImageUrl 업데이트
        await ref.read(addPlantProvider.notifier).updateDocId(docId);
        final userImageUrl = await ref
            .read(photoProvider.notifier)
            .uploadPhotoAndGetUserImageUrl();

        ref.read(addPlantProvider.notifier).updateUserImageUrl(userImageUrl);

        data = plantState.toJson();

        //직접 추가한 경우 informationState에 담긴 데이터와 , 넣은이미지를 information 필드에넣는다.(사용자가 넣은정보가 기본정보가됨)
        if (fromDirect) {
          data['information'] = informationState.toJson();
          data['information']['imageUrl'] = userImageUrl;
        } else {
          data['userImageUrl'] = userImageUrl;
        }

        data['timestamp'] = DateTime.now();
        data['information']['id'] = const Uuid().v4();
        data['docId'] = docId;

        await docRef.set(data);

        // Provider 상태 초기화
        ref.read(photoProvider.notifier).reset();
        ref.read(alarmProvider.notifier).reset();
        ref.read(addPlantProvider.notifier).reset();
        ref.read(informationProvider.notifier).reset();
      } catch (e) {
        // 오류가 발생한 경우 처리
        // print('오류: $e');
        // print('StackTrace: $stackTrace');
        // 필요한 대로 오류 처리
      }
    }

    return DefaultLayout(
      title: '식물추가',
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 24.w,
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () async {
          showLoadingDialog(context);
          if (isTapHandled) {
            Navigator.pop(context);
            return;
          } else {
            isTapHandled = true;
            try {
              await insertNewPlant();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const RootTab(initialTabIndex: 1),
                ),
                (route) => false,
              );
              await Future.delayed(const Duration(milliseconds: 1500));
            } catch (e) {
              // 에러가 발생할 때 필요한 처리
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const ErrorScreen(errorMessage: "식물 추가 에러"),
                ),
                (route) => false,
              );
              await Future.delayed(const Duration(milliseconds: 1500));
              isTapHandled = false;
            } finally {
              if (context.mounted) {
                Navigator.pop(context);
              }
              //한번누르면 무조건 에러가나지않는이상 isTapHandled 을 true로 유지한다
              // if (context.mounted) {
              //   isTapHandled = false;
              // }
            }
          }
        },
        child: Container(
          height: 46.w,
          width: 360.w,
          decoration: const BoxDecoration(color: pointColor2),
          child: Center(
            child: Text(
              "식물 추가 완료",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
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
                height: 20.h,
              ),
              Center(
                child: Container(
                  width: 360.w,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.w),
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
                      if (photoState != null)
                        Stack(
                          children: [
                            ProfileImageWidget(
                              imageProvider: FileImage(photoState),
                              size: 60.w,
                              radius: 24.w,
                            ),
                          ],
                        )
                      else if (plantState.information.imageUrl != "")
                        ProfileImageWidget(
                          imageProvider:
                              NetworkImage(plantState.information.imageUrl),
                          size: 60.w,
                          radius: 24.w,
                        )
                      else
                        ProfileImageWidget(
                          imageProvider:
                              const AssetImage('assets/images/pot.png'),
                          size: 60.w,
                          radius: 24.w,
                        ),
                      SizedBox(
                        height: 12.h,
                      ),
                      if (plantState.alias != "")
                        Center(
                          child: Text(
                            plantState.alias,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: keyColor700,
                                    ),
                          ),
                        ),
                      if (plantState.information.name != "")
                        SizedBox(
                          height: 2.h,
                        ),
                      if (plantState.information.name != "")
                        Text(
                          plantState.information.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
          vertical: 10.w,
          horizontal: 12.w,
        ),
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
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      iconPath,
                      width: 16.w,
                      height: 16.w,
                    ),
                    SizedBox(
                      width: 4.w,
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
                  height: 8.w,
                ),
                Container(
                  width: 360.w,
                  padding: EdgeInsets.symmetric(
                    vertical: 10.w,
                    horizontal: 20.w,
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
                              dateFormatter(alarmState.startTime
                                  .add(Duration(days: alarmState.repeat))),
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
