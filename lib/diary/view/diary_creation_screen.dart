import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                IconButton(
                  icon: const Image(
                    image: AssetImage('assets/icons/add_emoji.png'),
                    width: 32,
                    height: 32,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                const SizedBox(width: 24),
                Stack(
                  children: [
                    ProfileImageWidget(
                      imageProvider:
                          const AssetImage('assets/images/plants/plantA.png'),
                      size: 168.h,
                      radius: 12.h,
                    ),
                    Positioned(
                      right: -1,
                      top: -1,
                      child: GestureDetector(
                        onTap: () {
                          // GestureDetector를 터치했을 때 수행할 동작
                        },
                        child: Image(
                          image: const AssetImage('assets/icons/x.png'),
                          width: 20.h,
                          height: 20.h,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                ProfileImageWidget(
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
                  size: 168.h,
                  radius: 12.h,
                ),
                const SizedBox(width: 16),
                ProfileImageWidget(
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
                  size: 168.h,
                  radius: 12.h,
                ),
                const SizedBox(width: 16),
                ProfileImageWidget(
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
                  size: 168.h,
                  radius: 12.h,
                ),
                const SizedBox(width: 24),
              ],
            ),
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
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  child: Row(
                                    children: [
                                      const Image(
                                        image: AssetImage(
                                            'assets/icons/camera.png'),
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
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
