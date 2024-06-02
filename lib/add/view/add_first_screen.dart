import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/information_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/add/widget/alarm_box_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';

class AddFirstScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addFirst';
  final bool fromDirect;
  const AddFirstScreen({
    super.key,
    this.fromDirect = false,
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
        icon: Icon(
          Icons.arrow_back,
          size: 24.w,
        ),
        onPressed: () {
          if (widget.fromDirect == false) {
            ref.read(photoProvider.notifier).reset();
            ref.read(alarmProvider.notifier).reset();
            ref.read(addPlantProvider.notifier).reset();

            Navigator.pop(context);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (!widget.fromDirect && plantState.information.id != "") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddSecondScreen();
                },
              ),
            );
          }
          if (widget.fromDirect) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddSecondScreen(fromDirect: true);
                },
              ),
            );
          }
        },
        child: Container(
          height: 46.w,
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
              AddPlantCard(
                fromDirect: widget.fromDirect,
              ),
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
                height: 40.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlantCard extends ConsumerStatefulWidget {
  final bool fromDirect;
  const AddPlantCard({
    super.key,
    this.fromDirect = false,
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
    final InformationModel informationState = ref.watch(informationProvider);
    return Center(
      child: Container(
        width: 360.w,
        padding: EdgeInsets.all(20.w),
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          //x 버튼 유무
                          if (photoState != null)
                            Stack(children: [
                              ProfileImageWidget(
                                imageProvider: FileImage(photoState),
                                size: 60.w,
                                radius: 24.w,
                              ),
                              if (!widget.fromDirect)
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
                                        width: 16.w,
                                        height: 16.w,
                                      )),
                                ),
                            ])
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
                            )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Text(
                          widget.fromDirect
                              ? informationState.name
                              : plantState.information.name,
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: grayBlack,
                                  ),
                          maxLines: 2,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                    ],
                  ),
                ),
                if (!widget.fromDirect)
                  GestureDetector(
                    onTap: () => showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.w),
                        ),
                      ),
                      builder: (context) => Padding(
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("식물 사진 추가",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(color: grayBlack)),
                            SizedBox(
                              height: 22.h,
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10.0.w),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                ref
                                    .read(photoProvider.notifier)
                                    .setNewPhoto(camera: true);
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
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
                            TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10.0.w),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
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
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                      decoration: BoxDecoration(
                        color: Colors.white, // 전체 배경색
                        border: Border.all(
                          color: pointColor2.withOpacity(0.5), // 테두리 색상
                          width: 1.0.w,
                        ),
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20.0.w),
                          right: Radius.circular(20.0.w),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          photoState != null ? '사진 변경' : '사진 추가',
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: pointColor2,
                                  ),
                        ),
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: TextFormField(
                    controller: textController,
                    onChanged: (text) {
                      ref.read(addPlantProvider.notifier).updateAlias(text);
                    },
                    maxLength: 20,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.start,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
                    decoration: InputDecoration(
                      counterText: '',
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 4.0.w,
                      ),
                      child: Text(
                        '별칭(선택)',
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
