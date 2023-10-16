import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'dart:io';

class AddDirectlyScreen extends StatelessWidget {
  const AddDirectlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '식물 추가',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32.h,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyPicture(),
                ],
              ),
              SizedBox(
                height: 28.h,
              ),
              const PlantName(),
              SizedBox(
                height: 24.h,
              ),
              const Tip()
            ],
          ),
        ),
      ),
    );
  }
}

class MyPicture extends ConsumerWidget {
  const MyPicture({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final File? photoState = ref.watch(photoProvider);

    return GestureDetector(
      onTap: () => showModalBottomSheet(
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
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  ref.read(photoProvider.notifier).setNewPhoto(camera: true);
                },
                child: Align(
                  alignment: const Alignment(-1.0, 0.0),
                  child: Text(
                    "카메라",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  Navigator.pop(context);
                  ref.read(photoProvider.notifier).setNewPhoto(camera: false);
                },
                child: Align(
                  alignment: const Alignment(-1.0, 0.0),
                  child: Text(
                    "갤러리 사진 선택",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor700,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: photoState == null
          ? Container(
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.h),
                  color: grayColor200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/camera.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "사진추가",
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: grayColor500,
                        ),
                  ),
                ],
              ),
            )
          : ProfileImageWidget(
              imageProvider: FileImage(photoState),
              size: 100.h,
              radius: 40.h,
            ),
    );
  }
}

class PlantName extends ConsumerStatefulWidget {
  const PlantName({super.key});

  @override
  ConsumerState<PlantName> createState() => _PlantNameState();
}

class _PlantNameState extends ConsumerState<PlantName> {
  TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '식물 이름',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: primaryColor),
        ),
        SizedBox(
          height: 8.h,
        ),
        SizedBox(
          height: 42.h,
          child: Column(
            children: [
              TextFormField(
                controller: textController,
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: grayBlack),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.fromLTRB(16, 10.h, 16, 10.h),
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
                  hintText: '식물 이름을 입력해주세요',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grayColor400),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Tip extends StatefulWidget {
  const Tip({super.key});

  @override
  State<Tip> createState() => _TipState();
}

class _TipState extends State<Tip> {
  TextEditingController tipListController = TextEditingController();
  List<String> leftTipList = ['물주기', '햇빛', '온도', '습도', '분갈이'];
  List<String> addedTipList = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성장 TIP',
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: primaryColor),
        ),
        SizedBox(
          height: 4.h,
        ),
        Text(
          '해당 식물 상세페이지에서 볼 수 있어요',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: grayColor500),
        ),
        SizedBox(
          height: 12.h,
        ),
        ListView.builder(
          itemCount: addedTipList.length,
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //tipList 의 값이 중복되어 할수없다 ex/ 물주기 가두개있으면안됨
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 42.h,
                      width: 122.w,
                      child: CustomDropdown(
                        hintText: '선택',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: grayColor400),
                        selectedStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: grayBlack),
                        listItemStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: grayBlack),
                        borderSide: const BorderSide(
                          color: grayColor400,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        items: leftTipList,
                        controller: tipListController,
                        onChanged: (p0) {
                          setState(
                            () {},
                          );
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        'assets/icons/trash.png',
                        width: 18.h,
                        height: 18.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: grayColor400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    maxLines: null,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
                    decoration: InputDecoration(
                      isDense: true,
                      hintText:
                          '나중에도 계속해서 참고할 수 있도록 식물과 관련된 물주기 정보를 직접 입력해보세요!',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: grayColor400),
                      hintMaxLines: 3,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.h,
                ),
              ],
            );
          },
        ),

        //항상 맨아래에 있으며 추가하기를 누르면 위의 Column 이 늘어난다, tipList의 길이만큼만 추가할수있다.
        ElevatedButton(
          onPressed: (() {
            setState(() {
              addedTipList.add('a');
            });
          }),
          style: ElevatedButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: pointColor1,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            child: Text(
              '+ 추가하기 ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
