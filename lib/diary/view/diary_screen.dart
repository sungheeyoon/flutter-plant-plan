import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  const DiaryScreen({
    super.key,
  });

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: grayColor100,
      title: '다이어리',
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DateContainer(date: '2020-11-11'),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image name alias
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            ProfileImageWidget(
                              imageProvider: const AssetImage(
                                  'assets/icons/fav/fav_active.png'),
                              size: 28.h,
                              radius: 11.h,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              '안시리움',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: grayBlack,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          '몰라별명임마',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: keyColor700,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //divider
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(
                      color: grayColor200,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //emoji title dotdotdot
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.face,
                              size: 24.0,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              '반짝반짝 빛나는',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(
                                    color: grayBlack,
                                  ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.more_horiz,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  //images
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 24),
                        ProfileImageWidget(
                          imageProvider: const AssetImage(
                              'assets/icons/fav/fav_active.png'),
                          size: 120.h,
                          radius: 12.h,
                        ),
                        const SizedBox(width: 12),
                        ProfileImageWidget(
                          imageProvider: const AssetImage(
                              'assets/icons/fav/fav_active.png'),
                          size: 120.h,
                          radius: 12.h,
                        ),
                        const SizedBox(width: 12),
                        ProfileImageWidget(
                          imageProvider: const AssetImage(
                              'assets/icons/fav/fav_active.png'),
                          size: 120.h,
                          radius: 12.h,
                        ),
                        const SizedBox(width: 24),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  //context
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: ReadMoreText(
                      text:
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.뭐라고썻는지모르겟지?아네 ㅋㅋ 쩝ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ야임마모르것당',
                    ),
                  ),
                  //bookMark time
                  const SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.bookmark,
                          size: 24.0,
                          color: Colors.grey,
                        ),
                        Text(
                          '오후 7:38',
                          style:
                              Theme.of(context).textTheme.labelSmall!.copyWith(
                                    color: grayColor500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  final String date;
  const DateContainer({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: grayColor100,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              date,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: grayColor700,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  State<ReadMoreText> createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textSpan = TextSpan(
      text: widget.text,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: grayBlack,
          ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      maxLines: isExpanded ? null : 4,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final isTextOverflowed = textPainter.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: textSpan,
          maxLines: isExpanded ? null : 4,
          overflow: TextOverflow.ellipsis,
        ),
        if (isTextOverflowed)
          TextButton(
            onPressed: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Text(
              isExpanded ? '접기' : '더 보기',
              style: const TextStyle(color: Colors.blue),
            ),
          ),
      ],
    );
  }
}
