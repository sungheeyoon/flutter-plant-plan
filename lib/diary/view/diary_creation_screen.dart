import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/add/model/diary_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/plants_model.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';
import 'package:plant_plan/diary/provider/diary_provider.dart';
import 'package:plant_plan/services/firebase_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:plant_plan/utils/diary_utils.dart';

class DiaryCreationScreen extends ConsumerStatefulWidget {
  final DiaryCardModel? diaryCard;
  const DiaryCreationScreen({
    super.key,
    this.diaryCard,
  });

  @override
  ConsumerState<DiaryCreationScreen> createState() =>
      _DiaryCreationScreenState();
}

class _DiaryCreationScreenState extends ConsumerState<DiaryCreationScreen> {
  final ImagePicker picker = ImagePicker();
  String emoji = "";
  final List<XFile> images = [];
  List<String> netWorkImageUrls = [];
  SingleSelectController<String?> plantController = SingleSelectController<String?>(null);
  TextEditingController titleController = TextEditingController();
  TextEditingController contextController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<String> plantNameList = [];
  List<String> plantIdList = [];
  int index = -1;

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),
          insetPadding: EdgeInsets.zero,
          shape: const BeveledRectangleBorder(borderRadius: BorderRadius.zero),
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

  Future<void> galleryImage() async {
    if (netWorkImageUrls.length + images.length < 10) {
      List<XFile>? pics = await picker.pickMultiImage(imageQuality: 20);
      if (pics.isNotEmpty && pics.length + images.length <= 10) {
        setState(() {
          images.addAll(pics);
          scrollToMaxExtent();
        });
      }
    }
  }

  Future<void> cameraImage() async {
    if (netWorkImageUrls.length + images.length < 10) {
      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
      setState(() {
        if (image is XFile) {
          images.add(image);
          scrollToMaxExtent();
        }
      });
    }
  }

  Future<void> scrollToMaxExtent() async {
    await Future.delayed(const Duration(milliseconds: 500));
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void makePlantList(PlantsModel plants) {
    for (final plant in plants.data) {
      final plantName = plant.information.name +
          (plant.alias != "" ? '(${plant.alias})' : '');
      plantNameList.add(plantName);
      plantIdList.add(plant.docId);
    }
  }

  @override
  void initState() {
    super.initState();
    makePlantList(ref.read(plantsProvider) as PlantsModel);
    if (widget.diaryCard != null) {
      Future.delayed(Duration.zero, () {
        ref.read(diaryProvider.notifier).setDiary(widget.diaryCard!.diary);

        index = plantIdList.indexOf(widget.diaryCard!.docId);
        plantController.value = plantNameList[index];
      });
      titleController.text = widget.diaryCard!.diary.title;
      contextController.text = widget.diaryCard!.diary.context;
      emoji = widget.diaryCard!.diary.emoji;
      netWorkImageUrls = widget.diaryCard!.diary.imageUrl;
    } else {
      Future.delayed(Duration.zero, () {
        ref.read(diaryProvider.notifier).reset();
      });
    }
  }

  @override
  void dispose() {
    plantController.dispose();
    titleController.dispose();
    contextController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DiaryModel diaryState = ref.watch(diaryProvider);

    return DefaultLayout(
      title: '다이어리 작성',
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 24.w, // 원하는 크기로 조절
        ),
        onPressed: () {
          // 뒤로가기 동작
          Navigator.of(context).pop();
        },
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: TextButton(
            onPressed: () async {
              if (index != -1 &&
                  diaryState.title != "" &&
                  diaryState.context != "") {
                final docId = plantIdList[index];
                showLoadingDialog(context);

                //만약 netWorkImageUrls 가 삭제되었다면
                if (widget.diaryCard != null &&
                    netWorkImageUrls.toString() !=
                        diaryState.imageUrl.toString()) {
                  //삭제할 이미지를 deletedImageUrls 에 추가시킨다.
                  final List<String> deletedImageUrls = [];
                  for (final imageUrl in widget.diaryCard!.diary.imageUrl) {
                    if (!netWorkImageUrls.contains(imageUrl)) {
                      deletedImageUrls.add(imageUrl);
                    }
                  }
                  for (final imageUrl in deletedImageUrls) {
                    await CachedNetworkImage.evictFromCache(imageUrl);
                    await FirebaseService().deleteImageFromStorage(imageUrl);
                  }

                  await FirebaseService().syncImagesWithFirebaseStorage(
                      netWorkImageUrls, docId, widget.diaryCard!.diary.id);
                }

                //글쓰기인경우
                if (widget.diaryCard == null) {
                  //작성날짜를 현재로 설정한다.
                  ref.read(diaryProvider.notifier).setDateNow();
                  //변경,추가된 diary와 이미지를 추가삽입한다.
                  await FirebaseService()
                      .fireBaseAddDiary(docId, diaryState, images);
                } else {
                  await FirebaseService().fireBaseUpdateDiary(
                      docId, diaryState, netWorkImageUrls, images);
                }

                await ref.read(plantsProvider.notifier).updatedDiaryList(docId);
                ref.read(diaryProvider.notifier).reset();

                if (!context.mounted) return;
                Navigator.of(context).pop();
                Navigator.pop(context);
                final message = (widget.diaryCard != null)
                    ? '다이어리가 수정되었습니다'
                    : '다이어리가 추가되었습니다';
                showCustomToast(context, message);
              } else {
                return;
              }
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: const EdgeInsets.all(4),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              disabledForegroundColor:
                  const Color(0xFF999999).withOpacity(0.38),
            ),
            child: Text(
              '완료',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: index != -1 &&
                            diaryState.title != "" &&
                            diaryState.context != ""
                        ? pointColor2
                        : const Color(0xFF999999).withOpacity(0.38),
                  ),
            ),
          ),
        )
      ],
      child: Column(
        children: [
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomDropdown<String>(
              hintText: '식물을 선택해주세요',
              items: plantNameList.isEmpty ? ['No items'] : plantNameList,
              controller: plantController,
              decoration: CustomDropdownDecoration(
                closedBorderRadius: BorderRadius.circular(8),
                expandedBorderRadius: BorderRadius.circular(8),
                closedBorder: const Border.fromBorderSide(BorderSide(
                  color: grayColor400,
                  width: 1.0,
                )),
                expandedBorder: const Border.fromBorderSide(BorderSide(
                  color: grayColor400,
                  width: 1.0,
                )),
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: grayColor400),
                closedFillColor: Colors.white,
                expandedFillColor: Colors.white,
              ),
              onChanged: (p0) {
                setState(() {
                  index = plantNameList.indexOf(plantController.value ?? '');
                });
              },
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Divider(
            thickness: 8.w,
            color: grayColor100,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: titleController,
                    onChanged: (text) {
                      ref.read(diaryProvider.notifier).setTitle(text);
                    },
                    decoration: InputDecoration(
                        hintText: '제목',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: grayColor400),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grayColor400),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: grayBlack),
                        ),
                        counterText: ''),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
                    maxLength: 100,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    final newEmoji = await emojiModal(context);
                    setState(() {
                      if (newEmoji != null) {
                        emoji = newEmoji;
                        ref.read(diaryProvider.notifier).setEmoji(newEmoji);
                      }
                    });
                  },
                  child: emoji == ""
                      ? Image(
                          image: const AssetImage('assets/icons/add_emoji.png'),
                          width: 32.w,
                          height: 32.w,
                        )
                      : Image.asset(
                          'assets/icons/emoji/$emoji.png',
                          width: 32.w,
                          height: 32.w,
                        ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            child: Row(
                              children: [
                                const SizedBox(width: 24),
                                for (int index = 0;
                                    index < netWorkImageUrls.length;
                                    index++)
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          CachedNetworkImage(
                                            imageUrl: netWorkImageUrls[index],
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    ProfileImageWidget(
                                              imageProvider: imageProvider,
                                              size: 168.w,
                                              radius: 12.w,
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              width: 168.w,
                                              height: 168.w,
                                              child: const CircleAvatar(
                                                backgroundColor: grayColor200,
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                          Positioned(
                                            right: 6,
                                            top: 6,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  List<String> updatedUrls =
                                                      List.from(
                                                          netWorkImageUrls);
                                                  updatedUrls.removeAt(index);
                                                  netWorkImageUrls =
                                                      updatedUrls;
                                                });
                                              },
                                              child: Image(
                                                image: const AssetImage(
                                                    'assets/icons/x.png'),
                                                width: 20.w,
                                                height: 20.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index !=
                                              netWorkImageUrls.length - 1 ||
                                          images.isNotEmpty)
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                    ],
                                  ),
                                for (int index = 0;
                                    index < images.length;
                                    index++)
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          ProfileImageWidget(
                                            imageProvider: FileImage(
                                                File(images[index].path)),
                                            size: 168.w,
                                            radius: 12.w,
                                          ),
                                          Positioned(
                                            right: 6,
                                            top: 6,
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  images.removeAt(index);
                                                });
                                              },
                                              child: Image(
                                                image: const AssetImage(
                                                    'assets/icons/x.png'),
                                                width: 20.w,
                                                height: 20.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index != images.length - 1)
                                        SizedBox(
                                          width: 16.w,
                                        ),
                                    ],
                                  ),
                                const SizedBox(width: 24),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24.0),
                              child: TextField(
                                controller: contextController,
                                onChanged: (text) {
                                  ref
                                      .read(diaryProvider.notifier)
                                      .setContext(text);
                                },
                                decoration: InputDecoration(
                                  hintText: '내용을 입력해주세요',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: grayColor400),
                                  border: InputBorder.none,
                                  counterStyle: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(color: grayColor600),
                                ),
                                maxLines: null,
                                maxLength: 500,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: grayBlack),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.w, color: grayColor200),
                ),
              ),
              child: InkWell(
                onTap: () => showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.w),
                    ),
                  ),
                  builder: (context) => Column(
                    // 수정된 부분
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(32.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "식물 사진 추가",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: grayBlack),
                            ),
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
                                cameraImage();
                              },
                              child: Align(
                                alignment: Alignment.centerLeft, // 좌측 정렬
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
                                galleryImage();
                              },
                              child: Align(
                                alignment: Alignment.centerLeft,
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
                    ],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: const AssetImage('assets/icons/camera.png'),
                      width: 20.w,
                      height: 20.w,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Text(
                      images.isEmpty
                          ? "사진추가 (최대 10 장)"
                          : "사진추가 (${netWorkImageUrls.length + images.length}/10)",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: grayColor500),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> emojiModal(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: 312.w,
          height: 158.w,
          padding: EdgeInsets.symmetric(
            horizontal: 38.w,
          ),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '오늘의 기분을 알려주세요 \u{1F340}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grayBlack,
                      ),
                ),
                SizedBox(
                  height: 20.w,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.w),
                    border: Border.all(
                      width: 1.w,
                      color: grayColor300,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          return Navigator.of(context).pop("smile");
                        },
                        child: Image(
                          image:
                              const AssetImage('assets/icons/emoji/smile.png'),
                          width: 28.w,
                          height: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          return Navigator.of(context).pop("suprised");
                        },
                        child: Image(
                          image: const AssetImage(
                              'assets/icons/emoji/suprised.png'),
                          width: 28.w,
                          height: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          return Navigator.of(context).pop("crying");
                        },
                        child: Image(
                          image:
                              const AssetImage('assets/icons/emoji/crying.png'),
                          width: 28.w,
                          height: 28.w,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          return Navigator.of(context).pop("angry");
                        },
                        child: Image(
                          image:
                              const AssetImage('assets/icons/emoji/angry.png'),
                          width: 28.w,
                          height: 28.w,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
