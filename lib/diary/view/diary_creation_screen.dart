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
  TextEditingController plantController = TextEditingController();
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
        return AlertDialog(
          backgroundColor: Colors.black.withOpacity(0.7),
          content: const Center(
            child: CircularProgressIndicator(),
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
        plantController.text = plantNameList[index];
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
      actions: [
        TextButton(
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
                await FirebaseService()
                    .fireBaseUpdateDiary(docId, diaryState, images);
              }

              await ref.read(plantsProvider.notifier).updatedDiaryList(docId);
              ref.read(diaryProvider.notifier).reset();

              if (!context.mounted) return;
              Navigator.of(context).pop();
              Navigator.pop(context);
            } else {
              return;
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(right: 24),
            disabledForegroundColor: const Color(0xFF999999).withOpacity(0.38),
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
        )
      ],
      child: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CustomDropdown(
              hintText: '식물을 선택해주세요',
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
              items: plantNameList.isEmpty ? ['No items'] : plantNameList,
              controller: plantController,
              onChanged: (p0) {
                setState(() {
                  index = plantNameList.indexOf(plantController.text);
                });
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          const Divider(
            thickness: 8,
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
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
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
                      ? const Image(
                          image: AssetImage('assets/icons/add_emoji.png'),
                          width: 32,
                          height: 32,
                        )
                      : Image.asset(
                          'assets/icons/emoji/$emoji.png',
                          width: 32,
                          height: 32,
                        ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
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
                                              size: 168.h,
                                              radius: 12.h,
                                            ),
                                            placeholder: (context, url) =>
                                                SizedBox(
                                              width: 168.h,
                                              height: 168.h,
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
                                                width: 20.h,
                                                height: 20.h,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index !=
                                              netWorkImageUrls.length - 1 ||
                                          images.isNotEmpty)
                                        const SizedBox(
                                          width: 16,
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
                                            size: 168.h,
                                            radius: 12.h,
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
                                                width: 20.h,
                                                height: 20.h,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      if (index != images.length - 1)
                                        const SizedBox(
                                          width: 16,
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
                                ),
                                maxLines: null,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Divider(
                  thickness: 1,
                  color: grayColor200,
                ),
                InkWell(
                  onTap: () => showModalBottomSheet(
                    backgroundColor: Colors.white,
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
                              cameraImage();
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                              galleryImage();
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        const Image(
                          image: AssetImage('assets/icons/camera.png'),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 8,
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
                )
              ],
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
          height: 158.h,
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 32),
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
              Text(
                '오늘의 기분을 알려주세요 \u{1F340}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayBlack,
                    ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 1,
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
                      child: const Image(
                        image: AssetImage('assets/icons/emoji/smile.png'),
                        width: 28,
                        height: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        return Navigator.of(context).pop("suprised");
                      },
                      child: const Image(
                        image: AssetImage('assets/icons/emoji/suprised.png'),
                        width: 28,
                        height: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        return Navigator.of(context).pop("crying");
                      },
                      child: const Image(
                        image: AssetImage('assets/icons/emoji/crying.png'),
                        width: 28,
                        height: 28,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        return Navigator.of(context).pop("angry");
                      },
                      child: const Image(
                        image: AssetImage('assets/icons/emoji/angry.png'),
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    },
  );
}

class DiaryLoadingScreen extends StatelessWidget {
  const DiaryLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.black.withOpacity(0.7),
      content: const SizedBox(
        width: 80,
        height: 80,
        child: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
