import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/view/detail_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/common/utils/list_utils.dart';

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
  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<ListCardModel> cardList = getCardList(widget.plants);

    List<ListCardModel> selectedCardList;
    if (_selectedIndex == 1) {
      //cardList 의 card.title 문자순서대로 정렬되며 순서는 한글순,영어순,숫자순,특수문자순으로정렬한다.
      selectedCardList = [...cardList]..sort(compareByTitle);
    } else if (_selectedIndex == 2) {
      //cardList 의 card.dDay 오름차순으로 정렬되며 card.dDay 가 -1 이면 맨뒤로가게정렬한다.
      selectedCardList = [...cardList]..sort(compareByDDay);
    } else {
      selectedCardList = [...cardList]..sort(compareByTimeStamp);
    }
    return DefaultLayout(
      backgroundColor: const Color(0xFFF8F8F8),
      title: '내 식물',
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(24.h, 20.h, 24.h, 12.h),
        child: Column(
          children: [
            Row(
              children: [
                _buildButton(0, '최근 등록순'),
                SizedBox(width: 6.h),
                const VerticalLine(),
                SizedBox(width: 6.h),
                _buildButton(1, '이름순'),
                SizedBox(width: 6.h),
                const VerticalLine(),
                SizedBox(width: 6.h),
                _buildButton(2, '알림순'),
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
                return PlantListCard(cardData: card);
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

class PlantListCard extends ConsumerWidget {
  final ListCardModel cardData;

  const PlantListCard({
    super.key,
    required this.cardData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () async {
        final plant =
            await ref.watch(plantsProvider.notifier).getPlant(cardData.docId);
        ref.read(detailProvider.notifier).updateDetail(plant);
        if (!context.mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DetailScreen(),
          ),
        );
      },
      child: Container(
        width: 150.h,
        height: 160.h,
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12.h),
          boxShadow: [
            BoxShadow(
              color: const Color(0x1A000000),
              offset: Offset(0, 8.h),
              blurRadius: 8.h,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ProfileImageWidget(
                imageProvider: NetworkImage(cardData.imageUrl),
                size: 68.h,
                radius: 28.h),
            Text(
              cardData.title,
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: grayBlack,
                  ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.h),
                border: Border.all(width: 1.h, color: const Color(0xFFEDEDED)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 4.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (cardData.fields.isEmpty)
                    Image.asset(
                      'assets/icons/alarm_none.png',
                      width: 16.h,
                      height: 16.h,
                    ),
                  if (cardData.fields.contains(PlantField.watering))
                    Image.asset(
                      'assets/images/management/humid.png',
                      width: 14.h,
                      height: 14.h,
                      fit: BoxFit.contain,
                    ),
                  if (cardData.fields.contains(PlantField.repotting))
                    Image.asset(
                      'assets/images/management/repotting.png',
                      width: 14.h,
                      height: 14.h,
                      fit: BoxFit.contain,
                    ),
                  if (cardData.fields.contains(PlantField.nutrient))
                    Image.asset(
                      'assets/images/management/nutrient.png',
                      width: 14.h,
                      height: 14.h,
                      fit: BoxFit.contain,
                    ),
                  SizedBox(
                    width: 6.h,
                  ),
                  Text(
                    cardData.fields.isEmpty
                        ? '알림 없음'
                        : cardData.dDay == 0
                            ? 'TODAY'
                            : 'D-${cardData.dDay}',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: cardData.fields.isEmpty
                              ? const Color(0xFFDEDEDE)
                              : grayColor700,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
