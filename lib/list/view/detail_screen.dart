import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '내 식물',
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 6.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.h),
              child: const PlantDetailCard(),
            ),
            SizedBox(
              height: 16.h,
            ),
            TabBar(
              controller: _tabController,
              indicatorWeight: 2.h,
              tabs: [
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/tag.svg',
                        width: 16.h,
                        height: 16.h,
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 0 ? pointColor2 : grayColor400,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.h),
                      Text(
                        '관리 정보',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: _selectedIndex == 0
                                  ? pointColor2
                                  : grayColor400,
                            ),
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/svg/notetext.svg',
                        width: 16.h,
                        height: 16.h,
                        colorFilter: ColorFilter.mode(
                          _selectedIndex == 1 ? pointColor2 : grayColor400,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(width: 6.h),
                      Text(
                        '다이어리',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: _selectedIndex == 1
                                  ? pointColor2
                                  : grayColor400,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 200.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Center(child: Text('Tab 1 content')),
                  Center(child: Text('Tab 2 content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlantDetailCard extends StatefulWidget {
  const PlantDetailCard({
    super.key,
  });

  @override
  State<PlantDetailCard> createState() => _PlantDetailCardState();
}

class _PlantDetailCardState extends State<PlantDetailCard> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      padding: EdgeInsets.symmetric(
        horizontal: 16.h,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.h),
        boxShadow: [
          BoxShadow(
            color: grayBlack.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(2, 2), // Shadow position
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24.h),
                child: Image(
                  image: const AssetImage('assets/images/pot.png'),
                  width: 60.h,
                  height: 60.h,
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "테스트안시려",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: keyColor700,
                        ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Text(
                    "테스트안시려",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: grayBlack,
                        ),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                isFavorited = !isFavorited;
              });
            },
            child: Image(
              image: AssetImage(
                isFavorited
                    ? 'assets/icons/fav/fav_active.png'
                    : 'assets/icons/fav/fav_inactive.png',
              ),
              width: 28.h,
              height: 28.h,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final List<String> tabTitles;
  final int selectedIndex;
  final Function(int) onTabChanged;

  const CustomTabBar({
    super.key,
    required this.tabTitles,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: grayColor400, width: 2.h),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: tabTitles.map((title) {
          final index = tabTitles.indexOf(title);
          final isSelected = index == selectedIndex;
          final textColor = isSelected ? pointColor2 : grayColor400;
          final iconColor = isSelected ? pointColor2 : grayColor400;

          return GestureDetector(
            onTap: () => onTabChanged(index),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Row(
                children: [
                  SvgPicture.asset(
                    index == 0
                        ? 'assets/icons/svg/tag.svg'
                        : 'assets/icons/svg/notetext.svg',
                    width: 16.h,
                    height: 16.h,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                  SizedBox(width: 6.h),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: textColor,
                        ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
