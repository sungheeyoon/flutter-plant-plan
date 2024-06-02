import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/tip_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/widget/alarm_box_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/loading_screen.dart';
import 'package:plant_plan/common/widget/delete_modal.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/list/model/detail_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/provider/x_trigger_provider.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/list/wideget/tipButton_widget.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DetailModelBase detailState = ref.watch(detailProvider);
    if (detailState is DetailModelLoading) {
      return const LoadingScreen();
    } else if (detailState is DetailModelError) {
      return ErrorScreen(errorMessage: detailState.message);
    } else if (detailState is DetailModel) {
      return DefaultLayout(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 24.w,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteModal(
                    text: '식물을 삭제하시겠습니까?',
                    warning: '삭제하시면 해당 식물의 알림과 다이어리가 모두 삭제됩니다',
                    buttonText: '삭제',
                    isRed: false,
                    onPressed: () async {
                      await ref
                          .read(plantsProvider.notifier)
                          .deletePlant(detailState.data.docId);

                      await LocalNotificationService()
                          .deleteFromDocId(detailState.data.docId);

                      if (!context.mounted) return;
                      Navigator.of(context).pop();
                      //listScreen으로이동
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: Image.asset(
                'assets/icons/trash.png',
                width: 24.w,
                height: 24.w,
              ),
            ),
          )
        ],
        title: '내 식물',
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: const DetailCard(),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: const UpcomingAlarm(),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: const SettingAlarm(),
              ),
              SizedBox(
                height: 40.h,
              ),
              const Tips(),
              SizedBox(
                height: 80.h,
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class DetailCard extends ConsumerStatefulWidget {
  const DetailCard({
    super.key,
  });

  @override
  ConsumerState<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends ConsumerState<DetailCard> {
  File? newPhoto;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DetailModel detailState = ref.watch(detailProvider) as DetailModel;
    return Container(
      width: 360.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                newPhoto != null
                    ? ProfileImageWidget(
                        //새로운사진을 넣었을때
                        imageProvider: FileImage(newPhoto!),
                        size: 60.w,
                        radius: 24.w,
                      )
                    : ProfileImageWidget(
                        imageProvider: NetworkImage(
                          detailState.data.userImageUrl == ""
                              ? detailState.data.information.imageUrl
                              : detailState.data.userImageUrl,
                        ),
                        size: 60.w,
                        radius: 24.w,
                      ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (detailState.data.alias != "")
                        Text(
                          detailState.data.alias,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: keyColor700,
                                  ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      Text(
                        detailState.data.information.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: grayBlack,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  openDetailCardModal();
                },
                child: Image(
                  image: const AssetImage('assets/icons/edit.png'),
                  width: 24.w,
                  height: 24.w,
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              GestureDetector(
                onTap: () async {
                  setState(
                    () {
                      ref.read(detailProvider.notifier).toggleFavorite();
                      ref.read(plantsProvider.notifier).updatePlant(
                          detailState.data.docId,
                          favoriteToggle: true);
                    },
                  );
                },
                child: Image(
                  image: AssetImage(
                    detailState.data.favorite
                        ? 'assets/icons/fav/fav_active.png'
                        : 'assets/icons/fav/fav_inactive.png',
                  ),
                  width: 20.w,
                  height: 20.w,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> openDetailCardModal() async {
    final DetailModel detailState = ref.watch(detailProvider) as DetailModel;
    final result =
        await detailCardModal(detailState.data.alias); // 모달 창 열기 및 결과값 대기
    if (result == "updatedPhoto" || result == "updatedDelete") {
      //수정이된경우
      if (detailState.data.userImageUrl != "") {
        //기존이미지가 존재한다면 삭제
        await ref
            .read(photoProvider.notifier)
            .deleteImage(detailState.data.userImageUrl);
      }

      if (result == "updatedDelete") {
        //기존 사진을 삭제했을경우
        setState(() {
          ref.read(detailProvider.notifier).updateUserImageUrl("");
          newPhoto = null;
        });

        await ref
            .read(plantsProvider.notifier)
            .updatePlant(detailState.data.docId, userImageUrl: "");
      }
      if (result == "updatedPhoto") {
        //새로운 사진을 추가했을경우

        setState(() {
          newPhoto = ref.read(photoProvider);
        });

        //firebaseStore에 imageUpload
        final String newUserImageUrl = await ref
            .read(photoProvider.notifier)
            .uploadPhotoAndGetUserImageUrl();
        //변경된 imageUrl Detail State에 update
        ref.read(detailProvider.notifier).updateUserImageUrl(newUserImageUrl);
        //변경된 imageUrl State에 update
        await ref
            .read(plantsProvider.notifier)
            .updatePlant(detailState.data.docId, userImageUrl: newUserImageUrl);
      }
    }
    ref.read(xTriggerProvider.notifier).isFalse();
    ref.read(photoProvider.notifier).reset();
  }

  Future<dynamic> detailCardModal(String alias) {
    TextEditingController textController = TextEditingController(text: alias);

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        textController.selection =
            TextSelection.collapsed(offset: textController.text.length);
        return Consumer(
          builder: (_, ref, __) {
            final DetailModel detailState =
                ref.watch(detailProvider) as DetailModel;
            final File? photoState = ref.watch(photoProvider);
            final bool xTrigger = ref.watch(xTriggerProvider);

            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                width: 312.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.w),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x1A000000),
                      offset: Offset(0, 8),
                      blurRadius: 8,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 24.h),
                    Stack(
                      children: [
                        Stack(
                          children: [
                            if (photoState != null && xTrigger == false)
                              // 사용자가 새로운 이미지를 선택한 경우
                              Stack(
                                children: [
                                  ProfileImageWidget(
                                    imageProvider: FileImage(photoState),
                                    size: 60.w,
                                    radius: 24.w,
                                  ),
                                  Positioned(
                                    right: 1,
                                    top: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ref
                                              .read(photoProvider.notifier)
                                              .reset();
                                          ref
                                              .read(xTriggerProvider.notifier)
                                              .isTrue();
                                        });
                                      },
                                      child: Image(
                                        image: const AssetImage(
                                            'assets/icons/x.png'),
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else if (newPhoto != null && xTrigger == false)
                              Stack(
                                children: [
                                  ProfileImageWidget(
                                    imageProvider: FileImage(newPhoto!),
                                    size: 60.w,
                                    radius: 24.w,
                                  ),
                                  Positioned(
                                    right: 1,
                                    top: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ref
                                              .read(photoProvider.notifier)
                                              .reset();
                                          ref
                                              .read(xTriggerProvider.notifier)
                                              .isTrue();
                                        });
                                      },
                                      child: Image(
                                        image: const AssetImage(
                                            'assets/icons/x.png'),
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else if (detailState.data.userImageUrl != "" &&
                                xTrigger == false)
                              // 사용자가 기존 이미지를 선택한 경우
                              Stack(
                                children: [
                                  ProfileImageWidget(
                                    imageProvider: NetworkImage(
                                        detailState.data.userImageUrl),
                                    size: 60.w,
                                    radius: 24.w,
                                  ),
                                  Positioned(
                                    right: 1,
                                    top: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ref
                                              .read(xTriggerProvider.notifier)
                                              .isTrue();
                                        });
                                      },
                                      child: Image(
                                        image: const AssetImage(
                                            'assets/icons/x.png'),
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else if (detailState.data.information.imageUrl !=
                                "")
                              // 관리자가 저장한 이미지가 있는 경우
                              ProfileImageWidget(
                                imageProvider: NetworkImage(
                                    detailState.data.information.imageUrl),
                                size: 60.w,
                                radius: 24.w,
                              )
                            else
                              // 어떤 이미지도 없는 경우
                              ProfileImageWidget(
                                imageProvider:
                                    const AssetImage('assets/images/pot.png'),
                                size: 60.w,
                                radius: 24.w,
                              )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    if (detailState.data.information.name != "")
                      Text(
                        detailState.data.information.name,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundedButton(
                          onPressed: () {
                            setState(() {
                              ref
                                  .read(photoProvider.notifier)
                                  .setNewPhoto(camera: true);
                              ref.read(xTriggerProvider.notifier).isFalse();
                            });
                          },
                          font: Theme.of(context).textTheme.labelMedium,
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 90.w,
                          height: 30.w,
                          textColor: pointColor2,
                          name: '사진 찍기',
                        ),
                        SizedBox(width: 8.w),
                        RoundedButton(
                          onPressed: () {
                            setState(() {
                              ref
                                  .read(photoProvider.notifier)
                                  .setNewPhoto(camera: false);
                              ref.read(xTriggerProvider.notifier).isFalse();
                            });
                          },
                          font: Theme.of(context).textTheme.labelMedium,
                          backgroundColor: Colors.white,
                          borderColor: pointColor2.withOpacity(
                            0.5,
                          ),
                          width: 90.w,
                          height: 30.w,
                          textColor: pointColor2,
                          name: '사진 선택',
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 8.h),
                            child: TextFormField(
                              controller: textController,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: grayBlack),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(16.w, 10.w, 0, 10.w),
                                hintText: '내 식물의 별칭을 입력해주세요',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: grayColor400,
                                    ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8.0.w,
                                    ),
                                  ),
                                  borderSide: const BorderSide(
                                    width: 1,
                                    color: keyColor500,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: grayColor400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 12.w,
                            top: 0,
                            child: Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: Text(
                                  '별칭',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: grayColor600,
                                      ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey[200],
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (detailState.data.alias != textController.text) {
                          // 별칭이 수정됐을 경우
                          ref
                              .read(detailProvider.notifier)
                              .updateAlias(textController.text);

                          await ref.read(plantsProvider.notifier).updatePlant(
                                detailState.data.docId,
                                alias: textController.text,
                              );
                        }
                        if (xTrigger) {
                          // xTrigger 이면 기존사진삭제 및 기본사진으로
                          if (context.mounted) {
                            return Navigator.of(context).pop("updatedDelete");
                          }
                        } else if (photoState != null && xTrigger == false) {
                          // 새로운 이미지를 추가하는 경우
                          if (context.mounted) {
                            return Navigator.of(context).pop("updatedPhoto");
                          }
                        }
                        if (context.mounted) {
                          return Navigator.of(context).pop();
                        } // 모달 창 닫기
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // 버튼 배경색을 투명하게 설정
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                          ),
                        ),
                        elevation: 0,

                        side: BorderSide(
                            color: Colors.grey[200]!), // 하이라이트 시 테두리 추가
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.w),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "수정",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class UpcomingAlarm extends ConsumerWidget {
  const UpcomingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DetailModel detailState = ref.watch(detailProvider) as DetailModel;
    String watering = "";
    String repotting = "";
    String nutrient = "";
    List<AlarmModel> alarms = [];
    DateTime today = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
    );
    alarms = detailState.data.alarms;
    for (final alarm in alarms) {
      DateTime alarmDay = DateTime(
        alarm.startTime.year,
        alarm.startTime.month,
        alarm.startTime.day,
      );
      if (alarmDay == today) {
        alarmDay = alarmDay.add(Duration(days: alarm.repeat));
      }

      while (alarm.repeat > 0 && alarmDay.isBefore(today)) {
        alarmDay = alarmDay.add(Duration(days: alarm.repeat));
      }

      int difference = today.difference(alarmDay).inDays.abs();
      if (alarm.field == PlantField.watering && alarm.isOn) {
        watering = difference == 0 ? 'TODAY' : 'D-$difference';
      } else if (alarm.field == PlantField.repotting && alarm.isOn) {
        repotting = difference == 0 ? 'TODAY' : 'D-$difference';
      } else if (alarm.field == PlantField.nutrient && alarm.isOn) {
        nutrient = difference == 0 ? 'TODAY' : 'D-$difference';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "다가오는 알림",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: primaryColor),
        ),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //다가오는 알림 컨테이너
            Container(
              width: 98.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: const Color(0xFFAAE2F3),
                  width: 1.h,
                ),
              ),
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/management/humid.png',
                    width: 28.w,
                    height: 28.w,
                  ),
                  Text(
                    "물주기",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: const Color(0xFF72CBE7),
                        ),
                  ),
                  Text(
                    watering == "" ? '알림 없음' : watering,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: watering == "" ? grayColor400 : grayBlack,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: subColor2,
                  width: 1.h,
                ),
              ),
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/management/repotting.png',
                    width: 28.w,
                    height: 28.w,
                  ),
                  Text(
                    "분갈이",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: subColor2,
                        ),
                  ),
                  Text(
                    repotting == "" ? '알림 없음' : repotting,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: repotting == "" ? grayColor400 : grayBlack,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.h),
                border: Border.all(
                  color: keyColor500,
                  width: 1.h,
                ),
              ),
              padding: EdgeInsets.all(16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/management/nutrient.png',
                    width: 28.w,
                    height: 28.w,
                  ),
                  Text(
                    "영양제",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: keyColor500,
                        ),
                  ),
                  Text(
                    nutrient == "" ? '알림 없음' : nutrient,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: nutrient == "" ? grayColor400 : grayBlack,
                        ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class SettingAlarm extends StatelessWidget {
  const SettingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "알림 설정",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: primaryColor),
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBoxWidget(
          field: PlantField.watering,
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBoxWidget(
          field: PlantField.repotting,
          isDetail: true,
        ),
        SizedBox(
          height: 12.h,
        ),
        const AlarmBoxWidget(
          field: PlantField.nutrient,
          isDetail: true,
        ),
      ],
    );
  }
}

class Tips extends ConsumerStatefulWidget {
  const Tips({
    super.key,
  });

  @override
  ConsumerState<Tips> createState() => _TipsState();
}

class _TipsState extends ConsumerState<Tips> {
  int _selectedIndex = 0;
  List<TipModel> tipList = [];

  @override
  Widget build(BuildContext context) {
    final DetailModel detailState = ref.watch(detailProvider) as DetailModel;
    final List<TipModel> tipList = detailState.data.information.tips;

    if (tipList.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 24.h),
            child: Text(
              "성장 TIP",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: primaryColor),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(width: 24.h),
                for (int index = 0; index < tipList.length; index++)
                  TipButtonWidget(
                    text: tipList[index].part,
                    isFocused: _selectedIndex == index,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                  ),
                SizedBox(width: 16.h),
              ],
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Container(
              padding: EdgeInsets.all(20.h),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: grayColor100,
                borderRadius: BorderRadius.all(Radius.circular(12.h)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tipList[_selectedIndex].context,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
