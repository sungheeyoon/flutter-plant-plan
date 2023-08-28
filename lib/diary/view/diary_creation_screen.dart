import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class DiaryCreationScreen extends StatefulWidget {
  const DiaryCreationScreen({super.key});

  @override
  State<DiaryCreationScreen> createState() => _DiaryCreationScreenState();
}

class _DiaryCreationScreenState extends State<DiaryCreationScreen> {
  String emoji = "";
  final List<XFile> images = [];
  final ImagePicker picker = ImagePicker();

  Future<void> galleryImage() async {
    if (images.length < 10) {
      List<XFile>? pics = await picker.pickMultiImage(imageQuality: 20);
      if (pics.isNotEmpty && pics.length + images.length <= 10) {
        setState(() {
          images.addAll(pics);
        });
      }
    }
  }

  Future<void> cameraImage() async {
    if (images.length < 10) {
      final XFile? image =
          await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
      setState(() {
        if (image is XFile) {
          images.add(image);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final plantNameController = TextEditingController();

    return DefaultLayout(
      title: '다이어리 작성',
      actions: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: const EdgeInsets.only(right: 24),
            disabledForegroundColor: const Color(0xFF999999).withOpacity(0.38),
          ),
          child: Text(
            '완료',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(color: pointColor2),
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
              items: const ['안시리움', '개시려움', '선인장', '송죽장'],
              controller: plantNameController,
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
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                const SizedBox(width: 24),
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
                                                // GestureDetector를 터치했을 때 수행할 동작
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
                          "사진추가 (최대 10 장)",
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
