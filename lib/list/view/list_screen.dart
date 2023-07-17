import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/utils/colors.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _selectedIndex = 0;

  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ListCardModel test = ListCardModel(
        title: '저쩌고',
        imageUrl: 'assets/images/plants/plantA.png',
        dDay: 20,
        fields: []);
    return DefaultLayout(
      backgroundColor: const Color(0xFFF8F8F8),
      title: '내 식물리스트',
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
        child: Column(
          children: [
            Row(
              children: [
                _buildButton(0, '최근 등록순'),
                SizedBox(width: 6.h), // Add some space between buttons
                const VerticalLine(), // Use VerticalLine widget here
                SizedBox(width: 6.h), // Add some space between buttons
                _buildButton(1, '이름순'),
                SizedBox(width: 6.h), // Add some space between buttons
                const VerticalLine(), // Use VerticalLine widget here
                SizedBox(width: 6.h), // Add some space between buttons
                _buildButton(2, '알림순'),
              ],
            ),
            SizedBox(height: 12.h),
            PlantListCard(
              data: test,
            )
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
      width: 1,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFFDEDEDE),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}

class PlantListCard extends StatelessWidget {
  final ListCardModel data;

  const PlantListCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.h,
      height: 162.h,
      padding: EdgeInsets.all(16.h),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 68.h,
            height: 68.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.h),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(data.imageUrl),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            data.title,
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: grayBlack,
                ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              border: Border.all(width: 1, color: const Color(0xFFEDEDED)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (data.fields.isEmpty)
                  Image.asset(
                    'assets/icons/alarm_none.png',
                    width: 16.h,
                    height: 16.h,
                  ),
                if (data.fields.isEmpty) SizedBox(width: 4.h),
                if (data.fields.isNotEmpty &&
                    data.fields.length >
                        1) // Add condition to have SizedBox only if there are multiple images
                  SizedBox(width: 2.h), // Spacing between images
                if (data.fields.contains(PlantField.watering))
                  Image.asset(
                    'assets/images/management/humid.png',
                    width: 16.h,
                    height: 16.h,
                  ),
                if (data.fields.contains(PlantField.repotting)) ...[
                  if (data.fields.contains(PlantField.watering))
                    SizedBox(width: 2.h), // Spacing between images
                  Image.asset(
                    'assets/images/management/repotting.png',
                    width: 16.h,
                    height: 16.h,
                  ),
                ],
                if (data.fields.contains(PlantField.nutrient)) ...[
                  if (data.fields.contains(PlantField.watering) ||
                      data.fields.contains(PlantField.repotting))
                    SizedBox(width: 2.h), // Spacing between images
                  Image.asset(
                    'assets/images/management/nutrient.png',
                    width: 16.h,
                    height: 16.h,
                  ),
                ],
                if (data.fields
                    .isNotEmpty) // Add condition to have SizedBox only if there are multiple images
                  SizedBox(width: 8.h), // Space between images and text
                Text(
                  data.fields.isEmpty
                      ? '알림 없음'
                      : data.dDay == 0
                          ? 'TODAY'
                          : 'D-${data.dDay}',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: data.fields.isEmpty
                            ? const Color(0xFFDEDEDE)
                            : grayColor700,
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
