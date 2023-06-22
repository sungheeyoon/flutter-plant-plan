import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/user_info_model.dart';
import 'package:plant_plan/common/provider/selectedDateProvider.dart';
import 'package:plant_plan/common/provider/userInfoProvider.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/common/widget/home_calendar.dart';
import 'package:plant_plan/utils/colors.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    ref.read(userInfoProvider.notifier).fetchUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<UserInfoModel> userInfoList = ref.watch(userInfoProvider);
    final DateTime selectedDateState = ref.watch(selectedDateProvider);
    List<Alarm> getSelectedDateList(PlantField field) {
      List<Alarm> results = [];

      for (final userInfo in userInfoList) {
        Alarm alarm;

        if (field == PlantField.watering) {
          alarm = userInfo.info.watering.alarm;
        } else if (field == PlantField.repotting) {
          alarm = userInfo.info.repotting.alarm;
        } else {
          alarm = userInfo.info.nutrient.alarm;
        }

        // 알람이 켜져 있고 시작일이 지정되어 있으며 반복 주기가 0이 아니고 선택한 날짜와 일치하는 경우
        if (alarm.isOn &&
            alarm.startDay != null &&
            alarm.repeat == 0 &&
            (selectedDateState.year == alarm.startDay!.year &&
                selectedDateState.month == alarm.startDay!.month &&
                selectedDateState.day == alarm.startDay!.day)) {
          results.add(alarm); // 결과 리스트에 알람을 추가합니다.
        }

        // 반복 주기에 따라 알람을 추가합니다.
        if (alarm.repeat != 0) {
          DateTime currentDate = selectedDateState;
          DateTime startDate = alarm.startDay!;
          int difference = currentDate.difference(startDate).inDays;

          if (alarm.isOn &&
              alarm.startDay != null &&
              difference >= 0 &&
              difference % alarm.repeat == 0) {
            results.add(alarm); // 결과 리스트에 알람을 추가합니다.
          }
        }
      }

      return results;
    }

    List<Alarm> selectedDateWateringAlarms =
        getSelectedDateList(PlantField.watering);
    List<Alarm> selectedDateRepottingAlarms =
        getSelectedDateList(PlantField.repotting);
    List<Alarm> selectedDateNutrientAlarms =
        getSelectedDateList(PlantField.nutrient);

    return DefaultLayout(
      backgroundColor: pointColor2,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 194.h,
                child: const MyCalendar(),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              32.h,
                            ),
                            color: grayColor100,
                          ),
                          height: 54.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '해야할 일',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: grayColor500),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    '15', //selectedDateState 날짜에 매치된 userInfoList Alarm 갯수를 파악해서 넣는다
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: grayBlack),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1.0,
                                height: 16.h,
                                color: grayColor300,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '완료',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: grayColor500),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    '15', //selectedDateState 날짜에 매치된 userInfoList Alarm isOn 갯수를 파악해서 넣는다
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: grayBlack),
                                  ),
                                ],
                              ),
                              Container(
                                width: 1.0,
                                height: 16.h,
                                color: grayColor300,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '성공률',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(color: grayColor500),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  Text(
                                    '100%', //selectedDateState 날짜에 매치된 userInfoList Alarm isOn/userInfoList Alarm 갯수 를 퍼센트로 보여준다
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(color: grayBlack),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Text(
                              "TO-DO",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: primaryColor),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                // 아이콘 옆에 클릭했을 때 실행할 코드
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "탭별로 보기",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: grayColor500),
                                  ),
                                  SizedBox(
                                    width: 8.h,
                                  ),
                                  Image.asset(
                                    'assets/icons/home/change_view.png',
                                    width: 18.h,
                                    height: 18.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  setState(
                                    () {
                                      _currentPageIndex = 0;
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: _currentPageIndex == 0
                                      ? primaryColor
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30),
                                      right: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity:
                                          _currentPageIndex == 0 ? 1.0 : 0.75,
                                      child: Image.asset(
                                        'assets/images/management/humid.png',
                                        width: 16.h,
                                        height: 16.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Text(
                                      '물주기',
                                      style: _currentPageIndex == 0
                                          ? Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: primaryColor
                                                    .withOpacity(0.75),
                                              ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  setState(
                                    () {
                                      _currentPageIndex = 1;
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: _currentPageIndex == 1
                                      ? primaryColor
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30),
                                      right: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity:
                                          _currentPageIndex == 1 ? 1.0 : 0.75,
                                      child: Image.asset(
                                        'assets/images/management/repotting.png',
                                        width: 16.h,
                                        height: 16.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Text(
                                      '분갈이',
                                      style: _currentPageIndex == 1
                                          ? Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: primaryColor
                                                    .withOpacity(0.75),
                                              ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  setState(() {
                                    _currentPageIndex = 2;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: _currentPageIndex == 2
                                      ? primaryColor
                                      : Colors.white,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30),
                                      right: Radius.circular(30),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity:
                                          _currentPageIndex == 1 ? 1.0 : 0.75,
                                      child: Image.asset(
                                        'assets/images/management/nutrient.png',
                                        width: 16.h,
                                        height: 16.h,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                    Text(
                                      '영양제',
                                      style: _currentPageIndex == 2
                                          ? Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                color: Colors.white,
                                              )
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: primaryColor
                                                    .withOpacity(0.75),
                                              ),
                                    ),
                                    SizedBox(
                                      width: 4.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: grayColor200,
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      SizedBox(
                        height: 400.h,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          children: [
                            TodoTap(
                                selectedDateAlarms: selectedDateWateringAlarms,
                                field: PlantField.watering),
                            TodoTap(
                                selectedDateAlarms: selectedDateRepottingAlarms,
                                field: PlantField.repotting),
                            TodoTap(
                                selectedDateAlarms: selectedDateNutrientAlarms,
                                field: PlantField.nutrient),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TodoTap extends StatelessWidget {
  const TodoTap({
    super.key,
    required this.selectedDateAlarms,
    required this.field,
  });

  final List<Alarm> selectedDateAlarms;
  final PlantField field;

  @override
  Widget build(BuildContext context) {
    Color fieldColor;

    switch (field) {
      case PlantField.watering:
        fieldColor = const Color(0xFF72CBE7);
        break;
      case PlantField.repotting:
        fieldColor = subColor2;
        break;
      case PlantField.nutrient:
        fieldColor = keyColor400;
        break;
      default:
        fieldColor = Colors.transparent;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${selectedDateAlarms.length}개의 일정이 있어요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: fieldColor),
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              shrinkWrap: true,
              itemCount: selectedDateAlarms.length,
              itemBuilder: (BuildContext context, int index) {
                final alarm = selectedDateAlarms[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: AlarmCard(
                    field: field,
                    isDone: alarm.isOn,
                    name: alarm.title,
                    time: formatTime(alarm.startDay!),
                    imgUrl: 'assets/icons/home/change_view.png',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AlarmCard extends StatefulWidget {
  final PlantField field;
  final bool isDone;
  final String name;
  final String time;
  final String imgUrl;

  const AlarmCard({
    Key? key,
    required this.field,
    required this.isDone,
    required this.name,
    required this.time,
    required this.imgUrl,
  }) : super(key: key);

  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  late bool isDone;

  @override
  void initState() {
    isDone = widget.isDone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color fieldColor;

    switch (widget.field) {
      case PlantField.watering:
        fieldColor = const Color(0xFF72CBE7);
        break;
      case PlantField.repotting:
        fieldColor = subColor2;
        break;
      case PlantField.nutrient:
        fieldColor = keyColor400;
        break;
      default:
        fieldColor = Colors.transparent;
    }

    return Container(
      height: 60.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 8.h,
            decoration: BoxDecoration(
              color: fieldColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 12, 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36.h,
                        height: 36.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14.h),
                          image: DecorationImage(
                            image: AssetImage(widget.imgUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.h),
                      Text(
                        widget.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.time,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: primaryColor,
                                ),
                      ),
                      SizedBox(width: 8.h),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isDone = !isDone;
                          });
                        },
                        child: Icon(
                          isDone
                              ? Icons.check_circle
                              : Icons.check_circle_outline,
                          size: 28.h,
                          color: fieldColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
