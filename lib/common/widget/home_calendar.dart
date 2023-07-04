import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/common/provider/selectedDateProvider.dart';
import 'package:plant_plan/common/provider/userInfoProvider.dart';
import 'package:plant_plan/utils/colors.dart';

class MyCalendar extends ConsumerStatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  ConsumerState<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends ConsumerState<MyCalendar> {
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = 500;
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.165)
          ..addListener(
            () {
              setState(
                () {
                  _currentPage = _pageController.page?.round() ?? 0;
                  ref.read(selectedDateProvider.notifier).updateDateTime(
                      DateTime.now().add(Duration(days: _currentPage - 500)));
                },
              );
            },
          );
  }

  Widget _buildDateContainer({
    required DateTime date,
    required bool isToday,
    required bool isSelectedDay,
    PlantField? watering,
    PlantField? repotting,
    PlantField? nutrient,
  }) {
    final dayName = DateFormat.E().format(date);
    final dayNumber = DateFormat.d().format(date);

    List<Widget> dots = [];

    if (watering != null) {
      dots.add(
        Container(
          margin: const EdgeInsets.only(left: 2),
          width: 4.h,
          height: 4.h,
          decoration: BoxDecoration(
            color: subColor1,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    if (repotting != null) {
      dots.add(
        Container(
          margin: EdgeInsets.only(left: 4.h),
          width: 4.h,
          height: 4.h,
          decoration: BoxDecoration(
            color: subColor2,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    if (nutrient != null) {
      dots.add(
        Container(
          margin: EdgeInsets.only(left: 4.h),
          width: 4.h,
          height: 4.h,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 237, 0, 1),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      );
    }

    if (watering == null && repotting == null && nutrient == null) {
      dots.add(
        Container(
          margin: EdgeInsets.only(left: 4.h),
          width: 4.h,
          height: 4.h,
        ),
      );
    }

    double width =
        isSelectedDay ? MediaQuery.of(context).size.width * 0.8 : 46.h;
    double height =
        isSelectedDay ? MediaQuery.of(context).size.height * 0.8 : 74.h;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: (isSelectedDay && isToday)
            ? Colors.white
            : (isSelectedDay && !isToday)
                ? pointColor2
                : (!isSelectedDay && isToday)
                    ? Colors.white
                    : pointColor2,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(27.h),
          bottom: Radius.circular(27.h),
        ),
        border:
            isSelectedDay ? Border.all(color: Colors.white, width: 2) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: (isSelectedDay && isToday)
                ? Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: grayColor500)
                : (isSelectedDay && !isToday)
                    ? Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white)
                    : (!isSelectedDay && isToday)
                        ? Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: grayColor500)
                        : Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
          ),
          if (isSelectedDay) SizedBox(height: 2.h),
          Text(
            dayNumber,
            style: (isSelectedDay && isToday)
                ? Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: primaryColor)
                : (isSelectedDay && !isToday)
                    ? Theme.of(context)
                        .textTheme
                        .displayLarge!
                        .copyWith(color: Colors.white)
                    : (!isSelectedDay && isToday)
                        ? Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: primaryColor)
                        : Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: Colors.white.withOpacity(0.5),
                            ),
          ),
          SizedBox(height: isSelectedDay ? 8.h : 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dots,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<UserInfoModel> userInfoList = ref.watch(userInfoProvider);
    final DateTime selectedDateState = ref.watch(selectedDateProvider);
    return Container(
      color: pointColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 20.h,
                ),
                Text(
                  DateFormat.yMMM().format(selectedDateState),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                ),
                InkWell(
                  onTap: () {
                    // 클릭 이벤트 처리
                  },
                  child: Image.asset(
                    'assets/icons/home/statistical_chart.png',
                    width: 24.h,
                    height: 24.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30.h),
          SizedBox(
            height: 90.h,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 1000,
              itemBuilder: (BuildContext context, int index) {
                final now = DateTime.now().add(
                  Duration(days: index - 500),
                );
                final isSelectedDay = now.year == selectedDateState.year &&
                    now.month == selectedDateState.month &&
                    now.day == selectedDateState.day;
                final isToday = index == 500;
                //userInfo 에서 nextAlarm 이후부터 넣는다.
                //repeat에따라 주기를반복한다 repeat이 1이면 매일 repeat이7 이면 7일마다

                PlantField? watering;
                PlantField? repotting;
                PlantField? nutrient;

                for (final userInfo in userInfoList) {
                  final wateringAlarm = userInfo.info.watering.alarm;
                  if (wateringAlarm.isOn &&
                      wateringAlarm.repeat != 0 &&
                      (now.year == wateringAlarm.startTime.year &&
                              now.month == wateringAlarm.startTime.month &&
                              now.day == wateringAlarm.startTime.day ||
                          (now.isAfter(wateringAlarm.startTime) &&
                              now.difference(wateringAlarm.startTime).inDays %
                                      wateringAlarm.repeat ==
                                  0))) {
                    watering = PlantField.watering;
                  }
                  if (wateringAlarm.isOn &&
                      wateringAlarm.repeat == 0 &&
                      wateringAlarm.startTime.year == now.year &&
                      wateringAlarm.startTime.month == now.month &&
                      wateringAlarm.startTime.day == now.day) {
                    watering = PlantField.watering;
                  }

                  final repottingAlarm = userInfo.info.repotting.alarm;
                  if (repottingAlarm.isOn &&
                      repottingAlarm.repeat != 0 &&
                      (now.year == repottingAlarm.startTime.year &&
                              now.month == repottingAlarm.startTime.month &&
                              now.day == repottingAlarm.startTime.day ||
                          (now.isAfter(repottingAlarm.startTime) &&
                              now.difference(repottingAlarm.startTime).inDays %
                                      repottingAlarm.repeat ==
                                  0))) {
                    repotting = PlantField.repotting;
                  }
                  if (repottingAlarm.isOn &&
                      repottingAlarm.repeat == 0 &&
                      repottingAlarm.startTime.year == now.year &&
                      repottingAlarm.startTime.month == now.month &&
                      repottingAlarm.startTime.day == now.day) {
                    repotting = PlantField.repotting;
                  }
                  final nutrientAlarm = userInfo.info.nutrient.alarm;
                  if (nutrientAlarm.isOn &&
                      nutrientAlarm.repeat != 0 &&
                      (now.year == nutrientAlarm.startTime.year &&
                              now.month == nutrientAlarm.startTime.month &&
                              now.day == nutrientAlarm.startTime.day ||
                          (now.isAfter(nutrientAlarm.startTime) &&
                              now.difference(nutrientAlarm.startTime).inDays %
                                      nutrientAlarm.repeat ==
                                  0))) {
                    nutrient = PlantField.nutrient;
                  }
                  if (nutrientAlarm.isOn &&
                      nutrientAlarm.repeat == 0 &&
                      nutrientAlarm.startTime.year == now.year &&
                      nutrientAlarm.startTime.month == now.month &&
                      nutrientAlarm.startTime.day == now.day) {
                    nutrient = PlantField.nutrient;
                  }
                }

                return _buildDateContainer(
                  date: now,
                  isToday: isToday,
                  isSelectedDay: isSelectedDay,
                  watering: watering,
                  repotting: repotting,
                  nutrient: nutrient,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
