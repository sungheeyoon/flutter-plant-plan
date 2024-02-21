import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/provider/selected_date_provider.dart';
import 'package:plant_plan/utils/colors.dart';

class MyCalendar extends ConsumerStatefulWidget {
  final List<PlantModel> plants;
  const MyCalendar({super.key, required this.plants});

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
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: subColor1,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }

    if (repotting != null) {
      dots.add(
        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: subColor2,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }

    if (nutrient != null) {
      dots.add(
        Container(
          width: 4.w,
          height: 4.w,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(76, 237, 0, 1),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      );
    }

    double width =
        isSelectedDay ? MediaQuery.of(context).size.width * 0.8 : 46.w;
    double height =
        isSelectedDay ? MediaQuery.of(context).size.height * 0.8 : 75.h;

    return GestureDetector(
      onTap: () {
        // 선택한 날짜로 스크롤

        int pageIndex = 500 +
            date
                .difference(
                  DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ),
                )
                .inDays;

        // 선택한 페이지로 스크롤
        _pageController.animateToPage(
          pageIndex,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: 0.w,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 3.w,
        ),
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
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(90),
            bottom: Radius.circular(90),
          ),
          border:
              isSelectedDay ? Border.all(color: Colors.white, width: 2) : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              width: 25.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: dots,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SizedBox(
                //   width: 20.h,
                // ),
                Text(
                  DateFormat.yMMM().format(selectedDateState),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: Colors.white),
                ),
                //추가예정
                // InkWell(
                //   onTap: () {
                //     // 클릭 이벤트 처리
                //   },
                //   child: Image.asset(
                //     'assets/icons/home/statistical_chart.png',
                //     width: 24.h,
                //     height: 24.h,
                //   ),
                // ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 22.h),
            child: SizedBox(
              height: 90.w,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 1000,
                itemBuilder: (BuildContext context, int index) {
                  final now = DateTime(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).add(
                    Duration(days: index - 500),
                  );
                  final isSelectedDay = now.year == selectedDateState.year &&
                      now.month == selectedDateState.month &&
                      now.day == selectedDateState.day;
                  final isToday = index == 500;

                  PlantField? watering;
                  PlantField? repotting;
                  PlantField? nutrient;

                  for (final PlantModel plant in widget.plants) {
                    final List<AlarmModel> alarms = plant.alarms;

                    for (final AlarmModel alarm in alarms) {
                      DateTime zeroStartTime = DateTime(
                        alarm.startTime.year,
                        alarm.startTime.month,
                        alarm.startTime.day,
                      );

                      if (alarm.isOn &&
                              (alarm.repeat != 0 &&
                                  (now.isAfter(zeroStartTime) &&
                                      now.difference(zeroStartTime).inDays %
                                              alarm.repeat ==
                                          0)) ||
                          (alarm.repeat == 0 &&
                              selectedDateState == zeroStartTime)) {
                        if (alarm.field == PlantField.watering) {
                          watering = PlantField.watering;
                        } else if (alarm.field == PlantField.repotting) {
                          repotting = PlantField.repotting;
                        } else if (alarm.field == PlantField.nutrient) {
                          nutrient = PlantField.nutrient;
                        }
                      }
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
          ),
        ],
      ),
    );
  }
}
