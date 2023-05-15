import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/utils/colors.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late DateTime _selectedDate;
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentPage = 500;
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.165)
          ..addListener(() {
            setState(() {
              _currentPage = _pageController.page?.round() ?? 0;
              _selectedDate =
                  DateTime.now().add(Duration(days: _currentPage - 500));
            });
          });
  }

  Widget _buildDateContainer(DateTime date, bool isToday, bool isSelectedDay) {
    final dayName = DateFormat.E().format(date);
    final dayNumber = DateFormat.d().format(date);
    const alarmCount = 3; // TODO: replace this with actual alarm count
    final dots = List<Widget>.generate(
      alarmCount,
      (_) => Container(
        margin: const EdgeInsets.only(left: 2),
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );

    // final isSelectedDay = date.year == _selectedDate.year &&
    //     date.month == _selectedDate.month &&
    //     date.day == _selectedDate.day;

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
                  DateFormat.yMMM().format(_selectedDate),
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
                final isSelectedDay = now.year == _selectedDate.year &&
                    now.month == _selectedDate.month &&
                    now.day == _selectedDate.day;
                final isToday = index == 500;
                return _buildDateContainer(now, isToday, isSelectedDay);
              },
            ),
          ),
        ],
      ),
    );
  }
}
