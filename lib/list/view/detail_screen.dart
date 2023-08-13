import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/widget/alarm_box_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/provider/x_trigger_provider.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/list/wideget/tipButton_widget.dart';

class DetailScreen extends StatelessWidget {
  final PlantModel plant;
  const DetailScreen({
    super.key,
    required this.plant,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '내 식물',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: DetailCard(
                plant: plant,
              ),
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
  }
}

class DetailCard extends ConsumerStatefulWidget {
  final PlantModel plant;
  const DetailCard({
    super.key,
    required this.plant,
  });

  @override
  ConsumerState<DetailCard> createState() => _DetailCardState();
}

class _DetailCardState extends ConsumerState<DetailCard> {
  late bool isFavorite;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isFavorite = widget.plant.favorite;
    textController.text = widget.plant.alias;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  int calculateIsChangePhoto(
      File? photoState, String userImageUrl, String informationImageUrl) {
    if (photoState != null) {
      return 1;
    } else if (userImageUrl.isNotEmpty) {
      return 2;
    } else if (informationImageUrl.isNotEmpty) {
      return 3;
    } else {
      return 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ProfileImageWidget(
                imageProvider: NetworkImage(
                  widget.plant.userImageUrl == ""
                      ? widget.plant.information.imageUrl
                      : widget.plant.userImageUrl,
                ),
                size: 60.h,
                radius: 24.h,
              ),
              SizedBox(
                width: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.plant.alias != "")
                    Text(
                      widget.plant.alias,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: keyColor700,
                          ),
                    ),
                  //font height check
                  if (widget.plant.alias != "")
                    const SizedBox(
                      height: 0,
                    ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.plant.information.name,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                            ref.read(plantsProvider.notifier).updatePlant(
                                widget.plant.docId,
                                favoriteToggle: true);
                          });
                        },
                        child: Image(
                          image: AssetImage(
                            isFavorite
                                ? 'assets/icons/fav/fav_active.png'
                                : 'assets/icons/fav/fav_inactive.png',
                          ),
                          width: 20.h,
                          height: 20.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              detailCardModal();
            },
            child: Image(
              image: const AssetImage('assets/icons/edit.png'),
              width: 24.h,
              height: 24.h,
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> detailCardModal() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer(
          builder: (_, ref, __) {
            final File? photoState = ref.watch(photoProvider);
            final bool xTrigger = ref.watch(xTriggerProvider);
            final int isChangePhoto = calculateIsChangePhoto(
              ref.read(photoProvider),
              widget.plant.userImageUrl,
              widget.plant.information.imageUrl,
            );

            print('first ischangephotoadfasdf== $isChangePhoto');

            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                width: 312.w,
                height: 283.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
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
                                    size: 60.h,
                                    radius: 24.h,
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
                                        width: 16.h,
                                        height: 16.h,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else if (widget.plant.userImageUrl != "" &&
                                xTrigger == false)
                              // 사용자가 기존 이미지를 선택한 경우
                              Stack(
                                children: [
                                  ProfileImageWidget(
                                    imageProvider:
                                        NetworkImage(widget.plant.userImageUrl),
                                    size: 60.h,
                                    radius: 24.h,
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
                                        width: 16.h,
                                        height: 16.h,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            else if (widget.plant.information.imageUrl != "")
                              // 관리자가 저장한 이미지가 있는 경우
                              ProfileImageWidget(
                                imageProvider: NetworkImage(
                                    widget.plant.information.imageUrl),
                                size: 60.h,
                                radius: 24.h,
                              )
                            else
                              // 어떤 이미지도 없는 경우
                              ProfileImageWidget(
                                imageProvider:
                                    const AssetImage('assets/images/pot.png'),
                                size: 60.h,
                                radius: 24.h,
                              )
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    if (widget.plant.information.name != "")
                      Text(
                        widget.plant.information.name,
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
                          width: 90.h,
                          height: 30.h,
                          textColor: pointColor2,
                          name: '사진 찍기',
                        ),
                        SizedBox(width: 8.h),
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
                          width: 90.h,
                          height: 30.h,
                          textColor: pointColor2,
                          name: '사진 선택',
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            child: TextFormField(
                              controller: textController,
                              onChanged: (text) {
                                setState(() {
                                  textController.text = text;
                                });
                              },
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: grayBlack),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 16),
                                hintText: '내 식물의 별칭을 입력해주세요',
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: grayColor400,
                                    ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      8.0,
                                    ),
                                  ),
                                  borderSide: BorderSide(
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
                            left: 12,
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
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: InkWell(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        highlightColor: Colors.grey[200],
                        onTap: () async {
                          if (photoState != null && xTrigger == false) {
                            //widget.plant.userImageUrl = photoState 로 변경

                            if (widget.plant.userImageUrl != "") {
                              //이전 유저이미지 삭제
                              print('isChangePhto ==== $isChangePhoto');
                              try {
                                await ref
                                    .read(photoProvider.notifier)
                                    .deleteImage(widget.plant.userImageUrl);
                                print("Image deleted successfully");
                              } catch (error) {
                                print("Error deleting image: $error");
                              }
                            }
                            //Firebase 에 이미지 업로드후 imageUrl반환
                            final String userImageUrl = await ref
                                .read(photoProvider.notifier)
                                .uploadPhotoAndGetUserImageUrl();
                            //Firebase userImageUrl업데이트 및 plantsState변경
                            ref.read(plantsProvider.notifier).updatePlant(
                                widget.plant.docId,
                                userImageUrl: userImageUrl);
                          } else if (widget.plant.information.imageUrl != "") {
                            if (isChangePhoto != 3) {
                              if (isChangePhoto == 2) {
                                //기존 유저이미지 삭제후 유저이미지 ""
                              } else {
                                //유저이미지 ""
                              }
                            }
                          } else if (isChangePhoto == 4) {
                            print('Error:관리자 식물사진정보 누락');
                          }
                          ref.read(photoProvider.notifier).reset();
                          Navigator.of(context).pop();
                        },
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
                  ],
                ),
              ),
            );
          },
        );
      },
    ).then(
      (value) {
        Future.delayed(const Duration(milliseconds: 500), () {
          ref.read(photoProvider.notifier).reset();
          ref.read(xTriggerProvider.notifier).isFalse();
        });
      },
    );
  }
}

class DetailCardModal extends StatelessWidget {
  const DetailCardModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: 312,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
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
            mainAxisSize: MainAxisSize.min, // 모달 창 크기를 컨텐츠에 맞게 조절
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Modal Title",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("Your Content Here"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Perform an action
                },
                child: const Text("Confirm"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class UpcomingAlarm extends ConsumerWidget {
  const UpcomingAlarm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PlantModel? detailState = ref.watch(detailProvider);
    String watering = "";
    String repotting = "";
    String nutrient = "";
    List<AlarmModel> alarms = [];
    if (detailState != null) {
      DateTime today = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      );
      alarms = detailState.alarms;
      for (final alarm in alarms) {
        DateTime alarmDay = DateTime(
          alarm.startTime.year,
          alarm.startTime.month,
          alarm.startTime.day,
        );
        while (alarm.repeat > 0 && alarmDay.isBefore(today)) {
          alarmDay = alarmDay.add(Duration(days: alarm.repeat));
        }

        int difference = today.difference(alarmDay).inDays.abs();
        if (alarm.field == PlantField.watering) {
          watering = difference == 0 ? 'TODAY' : 'D-$difference';
        } else if (alarm.field == PlantField.repotting) {
          repotting = difference == 0 ? 'TODAY' : 'D-$difference';
        } else if (alarm.field == PlantField.nutrient) {
          nutrient = difference == 0 ? 'TODAY' : 'D-$difference';
        }
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
              height: 110.h,
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
                    width: 28.h,
                    height: 28.h,
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
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.h,
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
                    width: 28.h,
                    height: 28.h,
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
                          fontSize: 16,
                        ),
                  ),
                ],
              ),
            ),
            Container(
              width: 98.w,
              height: 110.h,
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
                    width: 28.h,
                    height: 28.h,
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
                          fontSize: 16,
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

class Tips extends StatefulWidget {
  const Tips({
    super.key,
  });

  @override
  State<Tips> createState() => _Tips();
}

class _Tips extends State<Tips> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
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
              TipButtonWidget(
                text: "물주기",
                isFocused: _selectedIndex == 0,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "햇빛",
                isFocused: _selectedIndex == 1,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "온도",
                isFocused: _selectedIndex == 2,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "습도",
                isFocused: _selectedIndex == 3,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "흙",
                isFocused: _selectedIndex == 4,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
              ),
              SizedBox(width: 8.h),
              TipButtonWidget(
                text: "분갈이",
                isFocused: _selectedIndex == 5,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 5;
                  });
                },
              ),
              SizedBox(width: 24.h),
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
                  "흙이 바싹 마르지 않게",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: grayBlack),
                ),
                SizedBox(
                  height: 16.h,
                ),
                Text(
                  "빠르게 성장하는 봄~가을에는 보통 주 1~2회 겉흙이 말랐을 때에 충분히 관수를 해주세요. 안시리움은 습한 환경을 좋아하는 특성을 가지고 있기 때문에 중간중간 잎에 분무를 해주어 습도를 올려주면 좋아요. 물을 준 뒤 통풍이 잘 되는 곳에서 관리해 주세요. 통풍이 안되는 곳에서 잎에 분무를 하게 되면 검은 점이 생길 수 있으니 조심하세요. 여름 장마철과 겨울에는 성장속도가 느려지기 때문에 물 주는 주기를 늘려 2주에 1번씩 주는 것이 좋아요.",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grayBlack),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
