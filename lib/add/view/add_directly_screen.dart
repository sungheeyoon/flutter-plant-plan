import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/tip_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/information_provider.dart';
import 'package:plant_plan/add/provider/photo_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'dart:io';
import 'package:plant_plan/add/view/add_first_screen.dart';

class AddDirectlyScreen extends ConsumerStatefulWidget {
  const AddDirectlyScreen({super.key});

  @override
  ConsumerState<AddDirectlyScreen> createState() => _AddDirectlyScreenState();
}

class _AddDirectlyScreenState extends ConsumerState<AddDirectlyScreen> {
  Set<String> dropdownItems = {'물주기', '햇빛', '온도', '습도', '분갈이'};
  List<TextEditingController> dropdownControllers = [];
  List<TextEditingController> contextControllers = [];
  List<String> previousValues = ['p', 'p', 'p', 'p', 'p'];
  late ScrollController _scrollController;

  void onAddDropdown() {
    setState(() {
      dropdownControllers.add(TextEditingController());
      contextControllers.add(TextEditingController());
      Future.delayed(const Duration(milliseconds: 200), () {
        scrollToBottom();
      });
    });
  }

  void onRemoveDropdown(int index) {
    setState(() {
      if (index >= 0 && index < dropdownControllers.length) {
        String removedItem = dropdownControllers[index].text;
        dropdownControllers.removeAt(index);
        contextControllers.removeAt(index);
        if (removedItem.isNotEmpty && !dropdownItems.contains(removedItem)) {
          dropdownItems.add(removedItem);
        }
      }
    });
  }

  List<TipModel> createTipModels(
      List<TextEditingController> dropdownControllers,
      List<TextEditingController> contextControllers) {
    assert(dropdownControllers.length == contextControllers.length,
        'Controllers length mismatch');

    List<TipModel> tipModels = [];

    for (int i = 0; i < dropdownControllers.length; i++) {
      final String part = dropdownControllers[i].text;
      final String context = contextControllers[i].text;

      if (part.isEmpty || context.isEmpty) {
        continue;
      }

      final TipModel tipModel = TipModel(part: part, context: context);
      tipModels.add(tipModel);
    }

    return tipModels;
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    for (var controller in dropdownControllers) {
      controller.dispose();
    }
    for (var controller in contextControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final informationState = ref.watch(informationProvider);
    final File? photoState = ref.watch(photoProvider);

    return DefaultLayout(
      title: '식물 추가',
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          ref.read(photoProvider.notifier).reset();
          ref.read(alarmProvider.notifier).reset();
          ref.read(addPlantProvider.notifier).reset();
          ref.read(informationProvider.notifier).reset();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const RootTab()),
              (route) => false);
        },
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          if (photoState != null && informationState.name.isNotEmpty) {
            final tips =
                createTipModels(dropdownControllers, contextControllers);
            ref.read(informationProvider.notifier).updateTips(tips);
            ref
                .read(addPlantProvider.notifier)
                .updateInformation(informationState);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddFirstScreen(
                    fromDirect: true,
                  );
                },
              ),
            );
          }
        },
        child: Container(
          height: 46.h,
          width: 360.w,
          decoration: BoxDecoration(
              color: photoState != null && informationState.name.isNotEmpty
                  ? pointColor2
                  : grayColor300),
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
        controller: _scrollController,
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
              Column(
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
                                        dropdownItems
                                            .add(previousValues[index]);
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 0),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: grayColor400),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: TextField(
                              controller: contextControllers[index],
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
                                contentPadding: const EdgeInsets.all(10),
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
                      onPressed: () {
                        onAddDropdown();
                        scrollToBottom();
                      },
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
              ),
              const SizedBox(
                height: 60,
              ),
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

class PlantName extends ConsumerWidget {
  const PlantName({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onChanged: (value) {
                  ref.read(informationProvider.notifier).updateName(value);
                },
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
