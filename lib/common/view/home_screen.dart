import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/alarm_with_userinfo.dart';
import 'package:plant_plan/common/provider/selected_date_provider.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/common/utils/home_utils.dart';
import 'package:plant_plan/common/widget/home_calendar.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/add/model/alarm_model.dart';

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
    ref.read(plantsProvider.notifier).fetchUserData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PlantModel> plantsState = ref.watch(plantsProvider);
    final DateTime selectedDateState = ref.watch(selectedDateProvider);

    //오늘 선택된 날짜의 알람들 전부 selectedDateAlarms 에 저장
    final List<AlarmWithUserInfo> selectedDateAlarms =
        getSelectedDateList(plantsState, selectedDateState);
    // 오늘 선택된 날짜의 알람들중 PlantField 별 filter
    final List<AlarmWithUserInfo> wateringAlarms = getSelectedDateList(
        plantsState, selectedDateState, PlantField.watering);
    final List<AlarmWithUserInfo> repottingAlarms = getSelectedDateList(
        plantsState, selectedDateState, PlantField.repotting);
    final List<AlarmWithUserInfo> nutrientAlarms = getSelectedDateList(
        plantsState, selectedDateState, PlantField.nutrient);

    //완료된 알람 카운트
    int completeCount =
        calculateCompleteCount(selectedDateAlarms, selectedDateState);
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
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 12.h,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ProgressWidget(
                          selectedDateAlarms: selectedDateAlarms,
                          completeCount: completeCount),
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
                                    duration: const Duration(milliseconds: 300),
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
                                    duration: const Duration(milliseconds: 300),
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
                                    duration: const Duration(milliseconds: 300),
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
                              selectedDateAlarms: wateringAlarms,
                              field: PlantField.watering),
                          TodoTap(
                              selectedDateAlarms: repottingAlarms,
                              field: PlantField.repotting),
                          TodoTap(
                              selectedDateAlarms: nutrientAlarms,
                              field: PlantField.nutrient),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
    required this.selectedDateAlarms,
    required this.completeCount,
  });

  final List<AlarmWithUserInfo> selectedDateAlarms;
  final int completeCount;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                '${selectedDateAlarms.length}',
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
                '$completeCount',
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
                '${selectedDateAlarms.isNotEmpty ? (completeCount / selectedDateAlarms.length * 100).toInt() : 0}%', //selectedDateState 날짜에 매치된 userInfoList Alarm isOn/userInfoList Alarm 갯수 를 퍼센트로 보여준다
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: grayBlack),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TodoTap extends ConsumerWidget {
  const TodoTap({
    super.key,
    required this.selectedDateAlarms,
    required this.field,
  });

  final List<AlarmWithUserInfo> selectedDateAlarms;
  final PlantField field;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateTime selectedDateState = ref.watch(selectedDateProvider);
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
                selectedDateAlarms.sort((a, b) {
                  final aHasOffDate =
                      a.alarm.offDates.contains(selectedDateState);
                  final bHasOffDate =
                      b.alarm.offDates.contains(selectedDateState);

                  if (aHasOffDate && !bHasOffDate) {
                    return 1; // a가 offDates를 가지고 있고 b가 가지고 있지 않은 경우 b를 더 앞에 배치
                  } else if (!aHasOffDate && bHasOffDate) {
                    return -1; // a가 offDates를 가지고 있지 않고 b가 가지고 있는 경우 a를 더 앞에 배치
                  } else {
                    return b.alarm.startTime.compareTo(a.alarm
                        .startTime); // offDates가 동일한 경우 startTime을 기준으로 정렬 (시간 순서를 반대로)
                  }
                });
                final info = selectedDateAlarms[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.h),
                  child: AlarmCard(
                    info: info,
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

class AlarmCard extends ConsumerStatefulWidget {
  final AlarmWithUserInfo info;

  const AlarmCard({
    Key? key,
    required this.info,
  }) : super(key: key);

  @override
  ConsumerState<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends ConsumerState<AlarmCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDateState = ref.watch(selectedDateProvider);
    bool isDone;

    if (widget.info.alarm.offDates.contains(selectedDateState)) {
      isDone = true;
    } else {
      isDone = false;
    }
    Color fieldColor;

    if (widget.info.alarm.field == PlantField.watering) {
      fieldColor = const Color(0xFF72CBE7);
    } else if (widget.info.alarm.field == PlantField.repotting) {
      fieldColor = subColor2;
    } else if (widget.info.alarm.field == PlantField.nutrient) {
      fieldColor = keyColor400;
    } else {
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
                      ProfileImageWidget(
                          imageProvider: NetworkImage(
                            widget.info.userImageUrl == ""
                                ? widget.info.information.imageUrl
                                : widget.info.userImageUrl,
                          ),
                          size: 36.h,
                          radius: 14.h),
                      SizedBox(width: 8.h),
                      Text(
                        widget.info.alias.isNotEmpty
                            ? widget.info.alias
                            : widget.info.information.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayBlack,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        formatTime(widget.info.alarm.startTime),
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
                            ref.read(plantsProvider.notifier).updateAlarm(
                                widget.info.alarm.id, widget.info.docId,
                                offTime: selectedDateState);
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
