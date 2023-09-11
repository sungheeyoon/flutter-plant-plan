import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/add/widget/alarm_box_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/common/widget/rounded_button.dart';
import 'package:plant_plan/utils/colors.dart';

class AddFirstScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addFirst';
  const AddFirstScreen({
    super.key,
  });

  @override
  ConsumerState<AddFirstScreen> createState() => _AddFirstScreenState();
}

class _AddFirstScreenState extends ConsumerState<AddFirstScreen> {
  @override
  Widget build(BuildContext context) {
    final PlantModel plantState = ref.watch(addPlantProvider);
    return DefaultLayout(
      title: '식물추가',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          ref.read(photoProvider.notifier).reset();
          ref.read(alarmProvider.notifier).reset();
          ref.read(addPlantProvider.notifier).reset();

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const RootTab()),
              (route) => false);
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (plantState.information.id != "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddSecondScreen();
                },
              ),
            );
          }
        },
        child: Container(
          height: 46.h,
          width: 360.w,
          decoration: const BoxDecoration(color: pointColor2),
          child: Center(
            child: Text(
              "다음",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              const AddPlantCard(),
              SizedBox(
                height: 32.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.timer_outlined,
                    size: 32.h,
                    color: pointColor2,
                  ),
                  SizedBox(
                    width: 8.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '식물 상태에 따라 관리 주기를',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: pointColor2,
                            ),
                      ),
                      Text(
                        '원하는대로 설정하고 알림을 받아보세요',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: pointColor2,
                            ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              const AlarmBoxWidget(
                field: PlantField.watering,
                isDetail: false,
              ),
              SizedBox(
                height: 12.h,
              ),
              const AlarmBoxWidget(
                field: PlantField.repotting,
                isDetail: false,
              ),
              SizedBox(
                height: 12.h,
              ),
              const AlarmBoxWidget(
                field: PlantField.nutrient,
                isDetail: false,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                '앱 알림 권한을 허용해야 정상적인 알림 서비스를 이용하실 수 있어요',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grayColor500,
                    ),
              ),
              SizedBox(
                height: 128.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlantCard extends ConsumerStatefulWidget {
  const AddPlantCard({
    super.key,
  });

  @override
  ConsumerState<AddPlantCard> createState() => _AddPlantCardState();
}

class _AddPlantCardState extends ConsumerState<AddPlantCard> {
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    final PlantModel plantState = ref.read(addPlantProvider);
    textController.text = plantState.alias;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PlantModel plantState = ref.watch(addPlantProvider);
    final File? photoState = ref.watch(photoProvider);
    return Center(
      child: Container(
        width: 360.w,
        padding: EdgeInsets.all(20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: grayBlack.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(2, 2), // Shadow position
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Stack(
                          children: [
                            //x 버튼 유무
                            if (photoState != null)
                              Stack(children: [
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
                                        ref
                                            .read(photoProvider.notifier)
                                            .reset();
                                      },
                                      child: Image(
                                        image: const AssetImage(
                                            'assets/icons/x.png'),
                                        width: 16.h,
                                        height: 16.h,
                                      )),
                                ),
                              ])
                            else if (plantState.information.imageUrl != "")
                              ProfileImageWidget(
                                imageProvider: NetworkImage(
                                    plantState.information.imageUrl),
                                size: 60.h,
                                radius: 24.h,
                              )
                            else
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
                    SizedBox(
                      width: 10.h,
                    ),
                    if (plantState.information.name != "")
                      Column(
                        children: [
                          Text(
                            plantState.information.name,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: grayBlack,
                                ),
                          ),
                        ],
                      ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RoundedButton(
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        builder: (context) => Container(
                          padding: const EdgeInsets.all(32),
                          height: 180.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("식물 사진 추가",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(color: grayBlack)),
                              SizedBox(
                                height: 32.h,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  ref
                                      .read(photoProvider.notifier)
                                      .setNewPhoto(camera: true);
                                },
                                child: Align(
                                  alignment: const Alignment(-1.0, 0.0),
                                  child: Text(
                                    "카메라",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: grayColor700,
                                        ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () async {
                                  Navigator.pop(context);
                                  ref
                                      .read(photoProvider.notifier)
                                      .setNewPhoto(camera: false);
                                },
                                child: Align(
                                  alignment: const Alignment(-1.0, 0.0),
                                  child: Text(
                                    "갤러리 사진 선택",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: grayColor700,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      font: Theme.of(context).textTheme.labelMedium,
                      backgroundColor: Colors.white,
                      borderColor: pointColor2.withOpacity(
                        0.5,
                      ),
                      width: 90.h,
                      height: 30.h,
                      textColor: pointColor2,
                      name: photoState != null ? '사진 변경' : '사진 추가',
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            //별칭
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: textController,
                    onChanged: (text) {
                      ref.read(addPlantProvider.notifier).updateAlias(text);
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
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
