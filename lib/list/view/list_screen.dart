import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/common/provider/userInfoProvider.dart';
import 'package:plant_plan/list/model/list_card_model.dart';
import 'package:plant_plan/utils/colors.dart';

class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

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
    final List<UserInfoModel> userInfoList = ref.watch(userInfoProvider);

    List<ListCardModel> getCardList() {
      List<ListCardModel> results = [];

      for (final UserInfoModel userInfo in userInfoList) {
        String id = userInfo.docId;
        String title = userInfo.info.alias == ""
            ? userInfo.plant.name
            : userInfo.info.alias;
        String imageUrl = userInfo.selectedPhotoUrl == ""
            ? userInfo.plant.image
            : userInfo.selectedPhotoUrl;

        DateTime today = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
        );

        List<Alarm> alarms = userInfo.info.alarms;
        if (alarms.isNotEmpty) {
          List<Alarm> closestAlarms = [];
          int minDifference = -1;

          for (Alarm alarm in alarms) {
            DateTime zeroStartTime = DateTime(
              alarm.startTime.year,
              alarm.startTime.month,
              alarm.startTime.day,
            );

            while (alarm.repeat != 0 && zeroStartTime.isBefore(today)) {
              zeroStartTime = zeroStartTime.add(Duration(days: alarm.repeat));
            }

            int difference = today.difference(zeroStartTime).inDays.abs();

            if (minDifference == -1 || difference < minDifference) {
              closestAlarms = [alarm];
              minDifference = difference;
            } else if (difference == minDifference) {
              closestAlarms.add(alarm);
            }
          }
        }
      }

      return results;
    }

    List<ListCardModel> plantData = getCardList();

    return DefaultLayout(
      backgroundColor: const Color(0xFFF8F8F8),
      title: '내 식물리스트',
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
                childAspectRatio: 150 / 160,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: plantData.length,
              itemBuilder: (context, index) {
                final plant = plantData[index];
                return PlantListCard(data: plant);
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
          Container(
            width: 68.h,
            height: 68.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.h),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(data.imageUrl),
              ),
            ),
          ),
          Text(
            data.title,
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
