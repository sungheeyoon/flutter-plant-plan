import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'dart:io';
import 'package:plant_plan/add/view/add_first_screen.dart';

class AddDirectlyScreen extends StatelessWidget {
  const AddDirectlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '식물 추가',
      bottomNavigationBar: GestureDetector(
        onTap: () {
          //여기서 사진 식물이름 들어왓는지확인하고싶어
          if (true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddFirstScreen();
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
  Set<String> dropdownItems = {'물주기', '햇빛', '온도', '습도', '분갈이'};
  List<TextEditingController> dropdownControllers = [];
  List<String> previousValues = ['p', 'p', 'p', 'p', 'p'];

  void onAddDropdown() {
    setState(() {
      dropdownControllers.add(TextEditingController());
    });
  }

  void onRemoveDropdown(int index) {
    setState(() {
      if (index >= 0 && index < dropdownControllers.length) {
        String removedItem = dropdownControllers[index].text;
        dropdownControllers.removeAt(index);
        if (removedItem.isNotEmpty && !dropdownItems.contains(removedItem)) {
          dropdownItems.add(removedItem);
        }
      }
    });
  }

  @override
  void dispose() {
    for (var controller in dropdownControllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
          shrinkWrap: true,
          itemCount: dropdownControllers.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            bool isFirstItem = index == 0;
            bool isLastItem = index == dropdownControllers.length - 1;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isFirstItem)
                  SizedBox(
                    height: 16.h,
                  ),
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
                        items: dropdownItems.toList(),
                        controller: dropdownControllers[index],
                        onChanged: (p0) {
                          setState(() {
                            if (previousValues[index] != 'p') {
                              dropdownItems.add(previousValues[index]);
                            }
                            dropdownItems.remove(p0);
                            previousValues[index] = p0;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onRemoveDropdown(index);
                      },
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
                if (!isLastItem)
                  Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      const Divider(
                        thickness: 1,
                        color: grayColor200,
                      ),
                    ],
                  ),
                if (isLastItem)
                  SizedBox(
                    height: 12.h,
                  ),
              ],
            );
          },
        ),
        if (dropdownControllers.length < 5)
          ElevatedButton(
            onPressed: onAddDropdown,
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
