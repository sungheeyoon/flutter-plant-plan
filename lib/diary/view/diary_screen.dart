import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/utils/diary_utils.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/diary/view/diary_creation_screen.dart';
import 'package:plant_plan/utils/colors.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  final List<PlantModel> plants;
  const DiaryScreen({
    super.key,
    required this.plants,
  });

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DiaryCardModel> cardList = getDiaryCardList(widget.plants);
    print(cardList);

    return DefaultLayout(
      backgroundColor: grayColor100,
      title: '다이어리',
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                border: Border.all(
                  color: grayColor400,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'All',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: grayColor500,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: IconButton(
            icon: const Image(
              image: AssetImage('assets/icons/edit.png'),
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DiaryCreationScreen()),
              );
            },
          ),
        ),
      ],
      child: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DateContainer(date: diaryCard.diary.date),
            DiaryCard(diaryCard: diaryCard),
          ],
        ),
      ),
    );
  }
}

class DiaryCard extends StatelessWidget {
  final DiaryCardModel diaryCard;
  const DiaryCard({
    super.key,
    required this.diaryCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                      imageProvider: NetworkImage(diaryCard.imageUrl),
                      size: 28.h,
                      radius: 11.h,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      diaryCard.name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
                Text(
                  diaryCard.alias,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
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
                    if (diaryCard.diary.emoji != "")
                      Image.asset(
                        'assets/icons/emoji/${diaryCard.diary.emoji}.png',
                        width: 24,
                        height: 24,
                      ),
                    if (diaryCard.diary.emoji != "")
                      const SizedBox(
                        width: 4,
                      ),
                    Text(
                      diaryCard.diary.title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
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
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
                  size: 120.h,
                  radius: 12.h,
                ),
                const SizedBox(width: 12),
                ProfileImageWidget(
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
                  size: 120.h,
                  radius: 12.h,
                ),
                const SizedBox(width: 12),
                ProfileImageWidget(
                  imageProvider:
                      const AssetImage('assets/images/plants/plantA.png'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ReadMoreText(
              text: diaryCard.diary.context,
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
                GestureDetector(
                  onTap: () {},
                  child: Image.asset(
                    'assets/icons/bookmark.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                Text(
                  '오후 7:38',
                  style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: grayColor500,
                      ),
                ),
              ],
            ),
          ),
        ],
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
  final int maxLines; // 최대 줄 수 설정

  const ReadMoreText({
    Key? key,
    required this.text,
    this.maxLines = 4, // 기본값으로 4 줄까지만 보이도록 설정
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
      maxLines: isExpanded ? null : widget.maxLines, // 최대 줄 수 적용
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final isTextOverflowed = textPainter.didExceedMaxLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: textSpan,
          maxLines: isExpanded ? null : widget.maxLines, // 최대 줄 수 적용
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
