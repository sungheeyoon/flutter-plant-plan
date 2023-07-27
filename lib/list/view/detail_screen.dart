import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/list/provider/detail_provider.dart';
import 'package:plant_plan/list/view/detail_info_tab.dart';
import 'package:plant_plan/utils/colors.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String id;
  const DetailScreen({
    super.key,
    required this.id,
  });

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  late Future<UserInfoModel> info;

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
              height: 820.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  DetailInfoTab(),
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

class PlantDetailCard extends ConsumerStatefulWidget {
  const PlantDetailCard({
    super.key,
  });

  @override
  ConsumerState<PlantDetailCard> createState() => _PlantDetailCardState();
}

class _PlantDetailCardState extends ConsumerState<PlantDetailCard> {
  bool isFavorited = false;
  @override
  Widget build(BuildContext context) {
    final UserInfoModel? data = ref.watch(detailProvider);
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
              Container(
                width: 60.h,
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.h),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(data?.selectedPhotoUrl == ""
                        ? data?.plant.image ?? ''
                        : data?.selectedPhotoUrl ?? ''),
                  ),
                ),
              ),
              SizedBox(
                width: 16.h,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (data?.info.alias != null && data?.info.alias != "")
                    Text(
                      data?.info.alias ?? '',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: keyColor700,
                          ),
                    ),
                  if (data?.info.alias != null && data?.info.alias != "")
                    SizedBox(
                      height: 6.h,
                    ),
                  Text(
                    data?.plant.name ?? '',
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
