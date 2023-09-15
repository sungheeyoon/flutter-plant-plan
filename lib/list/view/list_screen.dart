import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/delete_modal.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/provider/list_delete_mode_provider.dart';
import 'package:plant_plan/list/view/detail_screen.dart';
import 'package:plant_plan/list/wideget/plant_list_card.dart';
import 'package:plant_plan/common/utils/list_utils.dart';
import 'package:plant_plan/utils/colors.dart';

class ListScreen extends ConsumerStatefulWidget {
  final List<PlantModel> plants;
  const ListScreen({
    super.key,
    required this.plants,
  });

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  int _selectedIndex = 0;
  bool isFavorite = false;
  List<String> deleteIdList = [];

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void toggleDeleteIdListSelection(String docId) {
    setState(() {
      if (deleteIdList.contains(docId)) {
        deleteIdList.remove(docId);
      } else {
        deleteIdList.add(docId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool listDeleteModeState = ref.watch(listDeleteModeProvider);
    List<ListCardModel> cardList = isFavorite
        ? getCardList(widget.plants, true)
        : getCardList(widget.plants, false);

    List<ListCardModel> selectedCardList;
    if (_selectedIndex == 0) {
      //등록순
      selectedCardList = [...cardList]..sort(compareByTimeStamp);
    } else if (_selectedIndex == 1) {
      //알림순
      selectedCardList = [...cardList]..sort(compareByDDay);
    } else {
      selectedCardList = cardList;
    }
    return DefaultLayout(
      backgroundColor: const Color(0xFFF8F8F8),
      title: '내 식물',
      actions: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              ref
                  .read(listDeleteModeProvider.notifier)
                  .update((state) => !state);
              deleteIdList = [];
              isFavorite = false;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0),
            child: Image.asset(
              listDeleteModeState
                  ? 'assets/icons/cancel.png'
                  : 'assets/icons/trash.png',
              width: 24,
              height: 24,
            ),
          ),
        )
      ],
      bottomNavigationBar: listDeleteModeState
          ? GestureDetector(
              onTap: () {
                if (deleteIdList.isNotEmpty) {
                  //삭제 로직추가
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteModal(
                        text: '해당 식물을 삭제하시겠습니까?',
                        buttonText: '삭제하기',
                        onPressed: () async {
                          for (final deleteId in deleteIdList) {
                            await ref
                                .read(plantsProvider.notifier)
                                .deletePlant(deleteId);
                          }

                          //modal창종료
                          if (mounted) {
                            ref
                                .read(listDeleteModeProvider.notifier)
                                .update((state) => false);
                            deleteIdList = [];
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    },
                  );
                }
              },
              child: Container(
                height: 46.h,
                width: 360.w,
                decoration: BoxDecoration(
                    color:
                        deleteIdList.isNotEmpty ? pointColor2 : grayColor300),
                child: Center(
                  child: Text(
                    "삭제",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                        ),
                  ),
                ),
              ),
            )
          : null,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.h, 20.h, 24.h, 12.h),
        child: Column(
          children: [
            listDeleteModeState
                ? Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            deleteIdList = [];
                            for (final card in cardList) {
                              deleteIdList.add(card.docId);
                            }
                          });
                        },
                        child: Text(
                          '전체선택',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: cardList.length <= deleteIdList.length
                                      ? grayColor400
                                      : grayColor700),
                        ),
                      ),
                      SizedBox(width: 6.h),
                      const VerticalLine(),
                      SizedBox(width: 6.h),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            deleteIdList = [];
                          });
                        },
                        child: Text(
                          deleteIdList.isNotEmpty
                              ? '선택해제 (${deleteIdList.length})'
                              : '선택해제',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: deleteIdList.isNotEmpty
                                      ? grayColor700
                                      : grayColor400),
                        ),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          _buildButton(0, '최근 등록순'),
                          SizedBox(width: 6.h),
                          const VerticalLine(),
                          SizedBox(width: 6.h),
                          _buildButton(1, '알림순'),
                        ],
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              '즐겨찾기',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: isFavorite
                                          ? pointColor2
                                          : grayColor500),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(
                              isFavorite
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              size: 14.h,
                              color: isFavorite ? pointColor2 : grayColor500,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 12.h),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.h,
                mainAxisSpacing: 12.h,
                childAspectRatio: 150.w / 160.h,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: selectedCardList.length,
              itemBuilder: (context, index) {
                final ListCardModel card = selectedCardList[index];
                return GestureDetector(
                  onTap: () async {
                    final plant = await ref
                        .watch(plantsProvider.notifier)
                        .getPlant(card.docId);
                    if (listDeleteModeState) {
                      toggleDeleteIdListSelection(card.docId);
                    } else {
                      ref.read(detailProvider.notifier).updateDetail(plant);
                      if (!context.mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DetailScreen(),
                        ),
                      );
                    }
                  },
                  child: PlantListCard(
                    cardData: card,
                    isdeleteIdList: deleteIdList.contains(card.docId),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(int index, String text) {
    final isSelected = index == _selectedIndex;
    final color =
        isSelected ? const Color(0xFF388CED) : const Color(0xFFBBBBBB);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _onButtonTapped(index),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: color),
      ),
    );
  }
}

class VerticalLine extends StatelessWidget {
  const VerticalLine({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.h,
      height: 8.h,
      decoration: BoxDecoration(
        color: const Color(0xFFDEDEDE),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
