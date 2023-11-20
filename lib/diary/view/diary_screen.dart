import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/delete_modal.dart';
import 'package:plant_plan/diary/model/diary_card_model.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/diary/view/diary_creation_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';
import 'package:plant_plan/utils/diary_utils.dart';

class DiaryScreen extends ConsumerStatefulWidget {
  final List<PlantModel> plants;
  final bool bookMark;

  const DiaryScreen({
    super.key,
    required this.plants,
    this.bookMark = false,
  });

  @override
  ConsumerState<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends ConsumerState<DiaryScreen> {
  String selectedPlantDocId = "";
  String selectedPhotoUrl = "";
  bool isBookMark = false;

  @override
  void didUpdateWidget(covariant DiaryScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.bookMark) {
      setState(() {
        isBookMark = widget.bookMark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DiaryCardModel> cardList = isBookMark
        ? getDiaryCardList(
            plantsState: widget.plants,
            isBookMark: true,
            selectedPlantDocId: selectedPlantDocId,
          )
        : getDiaryCardList(
            plantsState: widget.plants,
            isBookMark: false,
            selectedPlantDocId: selectedPlantDocId,
          );

    String? previousDate;

    return DefaultLayout(
      backgroundColor: grayColor100,
      title: isBookMark ? '저장된 다이어리' : '다이어리',
      drawer: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(0), bottomRight: Radius.circular(0)),
        ),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          children: [
            SizedBox(
              height: 64.0.h,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.all(0.0),
                child: Text(
                  '식물별로 보기',
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: primaryColor,
                      ),
                ),
              ),
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 0.0),
              title: Row(
                children: [
                  Container(
                    width: 32.h,
                    height: 32.h,
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
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: grayColor500,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    '전체',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayBlack,
                        ),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  selectedPlantDocId = "";
                });

                Navigator.pop(context);
              },
            ),
            for (var plant in widget.plants)
              ListTile(
                contentPadding: const EdgeInsets.only(left: 0.0),
                title: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: plant.information.imageUrl,
                      imageBuilder: (context, imageProvider) =>
                          ProfileImageWidget(
                        imageProvider: imageProvider,
                        size: 32.h,
                        radius: 11.h,
                      ),
                      placeholder: (context, url) => SizedBox(
                        width: 32.h,
                        height: 32.h,
                        child: const CircleAvatar(
                          backgroundColor: grayColor200,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      plant.information.name,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
                onTap: () {
                  setState(
                    () {
                      setState(() {
                        selectedPlantDocId = plant.docId;
                        selectedPhotoUrl = plant.userImageUrl == ""
                            ? plant.information.imageUrl
                            : plant.userImageUrl;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
          ],
        ),
      ),
      leading: Builder(
        builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: selectedPlantDocId == ""
                  ? Row(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: grayColor500,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: selectedPhotoUrl,
                          imageBuilder: (context, imageProvider) =>
                              ProfileImageWidget(
                            imageProvider: imageProvider,
                            size: 28,
                            radius: 11,
                          ),
                          placeholder: (context, url) => const SizedBox(
                            width: 28,
                            height: 28,
                            child: CircleAvatar(
                              backgroundColor: grayColor200,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ],
                    ),
            ),
          );
        },
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
      child: selectedPlantDocId == "" && cardList.isEmpty
          ? Center(
              child: Text(
                '기록한 다이어리가 없습니다',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayColor600,
                    ),
              ),
            )
          : selectedPlantDocId != "" && cardList.isEmpty
              ? Center(
                  child: Text(
                    '해당 식물의 다이어리가 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                )
              : ListView.builder(
                  itemCount: cardList.length,
                  itemBuilder: (context, index) {
                    DiaryCardModel diaryCard = cardList[index];
                    String diaryDate = dateFormatter(diaryCard.diary.date);
                    bool last = false;
                    Widget dateWidget;
                    if (previousDate != diaryDate) {
                      dateWidget = DateContainer(date: diaryDate);
                      previousDate = diaryDate;
                      last = true;
                    } else {
                      dateWidget = const SizedBox.shrink();
                    }

                    return Column(
                      children: [
                        if (!last) const SizedBox(height: 8),
                        dateWidget,
                        DiaryCard(diaryCard: diaryCard),
                      ],
                    );
                  },
                ),
    );
  }
}

class DiaryCard extends ConsumerStatefulWidget {
  final DiaryCardModel diaryCard;
  const DiaryCard({
    super.key,
    required this.diaryCard,
  });

  @override
  ConsumerState<DiaryCard> createState() => _DiaryCardState();
}

class _DiaryCardState extends ConsumerState<DiaryCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.diaryCard.imageUrl,
                      imageBuilder: (context, imageProvider) =>
                          ProfileImageWidget(
                        imageProvider: imageProvider,
                        size: 28.h,
                        radius: 11.h,
                      ),
                      placeholder: (context, url) => SizedBox(
                        width: 28.h,
                        height: 28.h,
                        child: const CircleAvatar(
                          backgroundColor: grayColor200,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      widget.diaryCard.name,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
                Text(
                  widget.diaryCard.alias,
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
                    if (widget.diaryCard.diary.emoji != "")
                      Image.asset(
                        'assets/icons/emoji/${widget.diaryCard.diary.emoji}.png',
                        width: 24,
                        height: 24,
                      ),
                    if (widget.diaryCard.diary.emoji != "")
                      const SizedBox(
                        width: 4,
                      ),
                    Text(
                      widget.diaryCard.diary.title,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showDropdownMenu(widget.diaryCard);
                  },
                  child: const Icon(
                    Icons.more_horiz,
                    size: 24.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (widget.diaryCard.diary.imageUrl.isNotEmpty)
            const SizedBox(
              height: 8,
            ),
          //images
          if (widget.diaryCard.diary.imageUrl.isNotEmpty)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 24),
                  for (int index = 0;
                      index < widget.diaryCard.diary.imageUrl.length;
                      index++)
                    Row(
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.diaryCard.diary.imageUrl[index],
                          imageBuilder: (context, imageProvider) =>
                              ProfileImageWidget(
                            imageProvider: imageProvider,
                            size: 168.h,
                            radius: 12.h,
                          ),
                          placeholder: (context, url) => Container(
                            width: 168.h,
                            height: 168.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.h),
                              color: grayColor200,
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        if (index != widget.diaryCard.diary.imageUrl.length - 1)
                          const SizedBox(
                            width: 16,
                          ),
                      ],
                    ),
                  const SizedBox(width: 24),
                ],
              ),
            ),

          const SizedBox(
            height: 8,
          ),
          Container(
            width: 380.w,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ReadMoreText(
              text: widget.diaryCard.diary.context,
              maxLines: 4,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grayBlack,
                  ),
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
                  onTap: () {
                    ref.read(plantsProvider.notifier).toggleDiaryBookmark(
                        widget.diaryCard.docId, widget.diaryCard.diary.id);
                  },
                  child: Image.asset(
                    widget.diaryCard.diary.bookMark
                        ? 'assets/icons/bookmark.png'
                        : 'assets/icons/bookmark_outline.png',
                    width: 24,
                    height: 24,
                  ),
                ),
                Text(
                  formatKoreanTime(widget.diaryCard.diary.date),
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

  void showDropdownMenu(DiaryCardModel diaryCard) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset(236.w, 110));

    showMenu(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      surfaceTintColor: Colors.white,
      color: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx + button.size.width,
        position.dy + 1.0,
      ),
      items: [
        PopupMenuItem<String>(
          value: 'Edit',
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/icons/edit.png'),
                width: 20,
                height: 20,
                color: grayBlack,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                '수정하기',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grayBlack,
                    ),
              )
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'Delete',
          child: Row(
            children: [
              const Image(
                image: AssetImage('assets/icons/trash.png'),
                width: 20,
                height: 20,
                color: errorColor,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                '삭제하기',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: errorColor,
                    ),
              )
            ],
          ),
        ),
      ],
    ).then(
      (selectedValue) {
        if (selectedValue == 'Edit') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DiaryCreationScreen(
                diaryCard: diaryCard,
              ),
            ),
          );
        } else if (selectedValue == 'Delete') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteModal(
                text: '해당 다이어리를 삭제하시겠습니까?',
                buttonText: '삭제',
                isRed: false,
                onPressed: () {
                  ref
                      .read(plantsProvider.notifier)
                      .deleteDiary(diaryCard.diary.id, diaryCard.docId);
                  Navigator.of(context).pop();
                  showCustomToast(context, '다이어리가 삭제되었습니다.');
                },
              );
            },
          );
        }
      },
    );
  }
}

class ReadMoreText extends StatefulWidget {
  final String text;
  final int maxLines;
  final TextStyle textStyle;

  const ReadMoreText({
    super.key,
    required this.text,
    this.maxLines = 3, // 원하는 최대 라인 수 설정
    this.textStyle = const TextStyle(),
  });

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final TextSpan textSpan =
        TextSpan(text: widget.text, style: widget.textStyle);

    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        if (textPainter.didExceedMaxLines) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                textSpan,
                maxLines: isExpanded ? null : widget.maxLines,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    isExpanded ? '접기' : '더 보기',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grayColor500,
                        ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Text.rich(
            textSpan,
            maxLines: isExpanded ? null : widget.maxLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          );
        }
      },
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
