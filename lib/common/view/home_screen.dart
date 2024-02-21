import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/alarm_with_userinfo.dart';
import 'package:plant_plan/common/provider/alarm_setting_provider.dart';
import 'package:plant_plan/common/provider/selected_date_provider.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/widget/home_calendar.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';
import 'package:plant_plan/utils/home_utils.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  final List<PlantModel> plants;
  const HomeScreen({
    super.key,
    required this.plants,
  });

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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DateTime selectedDateState = ref.watch(selectedDateProvider);
    final List<AlarmWithUserInfo> selectedDateAlarms =
        getSelectedDateList(widget.plants, selectedDateState);
    return DefaultLayout(
      backgroundColor: pointColor2,
      child: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                pointColor2,
                Colors.white,
              ],
              stops: [0.5, 0.5],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              MyCalendar(plants: widget.plants),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.w),
                      topRight: Radius.circular(30.w),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: ProgressWidget(
                          selectedDateAlarms: selectedDateAlarms,
                          completeCount: calculateCompleteCount(
                              selectedDateAlarms, selectedDateState),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 2,
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
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: _currentPageIndex == 0
                                      ? primaryColor
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30.w),
                                      right: Radius.circular(30.w),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '전체',
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
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
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
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: _currentPageIndex == 1
                                      ? primaryColor
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30.w),
                                      right: Radius.circular(30.w),
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
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      '물주기',
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
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(2,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  setState(
                                    () {
                                      _currentPageIndex = 2;
                                    },
                                  );
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: _currentPageIndex == 2
                                      ? primaryColor
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30.w),
                                      right: Radius.circular(30.w),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity:
                                          _currentPageIndex == 2 ? 1.0 : 0.75,
                                      child: Image.asset(
                                        'assets/images/management/repotting.png',
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      '분갈이',
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
                                  ],
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: TextButton(
                                onPressed: () {
                                  _pageController.animateToPage(3,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut);
                                  setState(() {
                                    _currentPageIndex = 3;
                                  });
                                },
                                style: TextButton.styleFrom(
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(vertical: 8.w),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  backgroundColor: _currentPageIndex == 3
                                      ? primaryColor
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                      left: Radius.circular(30.w),
                                      right: Radius.circular(30.w),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Opacity(
                                      opacity:
                                          _currentPageIndex == 3 ? 1.0 : 0.75,
                                      child: Image.asset(
                                        'assets/images/management/nutrient.png',
                                        width: 16.w,
                                        height: 16.w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3.w,
                                    ),
                                    Text(
                                      '영양제',
                                      style: _currentPageIndex == 3
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
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          children: [
                            TodoTap(
                              selectedDateAlarms: selectedDateAlarms,
                              field: PlantField.none,
                            ),
                            TodoTap(
                                selectedDateAlarms: getSelectedDateList(
                                    widget.plants,
                                    selectedDateState,
                                    PlantField.watering),
                                field: PlantField.watering),
                            TodoTap(
                                selectedDateAlarms: getSelectedDateList(
                                    widget.plants,
                                    selectedDateState,
                                    PlantField.repotting),
                                field: PlantField.repotting),
                            TodoTap(
                                selectedDateAlarms: getSelectedDateList(
                                    widget.plants,
                                    selectedDateState,
                                    PlantField.nutrient),
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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                const SizedBox(
                  height: 2,
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
                const SizedBox(
                  height: 2,
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
                const SizedBox(
                  height: 2,
                ),
                Text(
                  //selectedDateState 날짜에 매치된 userInfoList Alarm isOn/userInfoList Alarm 갯수 를 퍼센트로 보여준다
                  '${selectedDateAlarms.isNotEmpty ? (completeCount / selectedDateAlarms.length * 100).toInt() : 0}%',
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
        fieldColor = primaryColor;
    }

    return selectedDateAlarms.isEmpty
        ? Center(
            child: Text(
              '오늘은 일정이 없어요',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grayColor600,
                  ),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    '${selectedDateAlarms.length}개의 일정이 있어요',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: fieldColor),
                  ),
                ),
                SizedBox(height: 8.h),
                ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  primary: false,
                  shrinkWrap: true,
                  itemCount: selectedDateAlarms.length,
                  itemBuilder: (BuildContext context, int index) {
                    selectedDateAlarms.sort((a, b) {
                      final aHasOffDate =
                          a.alarm.offDates.contains(selectedDateState);
                      final bHasOffDate =
                          b.alarm.offDates.contains(selectedDateState);

                      if (aHasOffDate && !bHasOffDate) {
                        return 1; // offDates를 가지고 있는 항목은 뒤로 배치
                      } else if (!aHasOffDate && bHasOffDate) {
                        return -1; // offDates를 가지고 있지 않은 항목은 앞으로 배치
                      } else {
                        // 시간만을 비교하도록 수정
                        final aTime = DateTime(0, 0, 0, a.alarm.startTime.hour,
                            a.alarm.startTime.minute);
                        final bTime = DateTime(0, 0, 0, b.alarm.startTime.hour,
                            b.alarm.startTime.minute);

                        return aTime.compareTo(bTime);
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

    Future<void> updateCheckBoxWithNotification() async {
      LocalNotificationService notificationService = LocalNotificationService();

      bool watering = ref.read(wateringProvider);
      bool repotting = ref.read(repottingProvider);
      bool nutrient = ref.read(nutrientProvider);

      if (widget.info.alarm.field == PlantField.watering && watering) {
        repotting = false;
        nutrient = false;
      } else if (widget.info.alarm.field == PlantField.repotting && repotting) {
        watering = false;
        nutrient = false;
      } else if (widget.info.alarm.field == PlantField.nutrient && nutrient) {
        watering = false;
        repotting = false;
      } else {
        watering = false;
        repotting = false;
        nutrient = false;
      }
      //plant 를 docId를 통해 가져옴
      final plant =
          await ref.read(plantsProvider.notifier).getPlant(widget.info.docId);
      //offDates 에 해당 날짜를 토글하여 넣거나 삭제
      await ref.read(plantsProvider.notifier).updateAlarm(
          widget.info.alarm.id, widget.info.docId,
          offTime: selectedDateState);
      //수정된 알림 우선삭제
      await notificationService.deleteFromFieldWithDocId(
          widget.info.alarm.field, widget.info.docId);
      //수정된 알림  업데이트
      await notificationService.scheduleAlarmNotifications(
        plant: plant,
        watering: watering,
        repotting: repotting,
        nutrient: nutrient,
      );
    }

    if (widget.info.alarm.offDates.contains(selectedDateState)) {
      isDone = true;
    } else {
      isDone = false;
    }
    Color fieldColor;
    String field;
    if (widget.info.alarm.field == PlantField.watering) {
      fieldColor = subColor1;
      field = '물주기';
    } else if (widget.info.alarm.field == PlantField.repotting) {
      fieldColor = subColor2;
      field = '분갈이';
    } else if (widget.info.alarm.field == PlantField.nutrient) {
      fieldColor = keyColor400;
      field = '영양제';
    } else {
      fieldColor = Colors.transparent;
      field = 'none';
    }

    return Container(
      width: 360.w,
      height: 60.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.h),
        boxShadow: const [
          BoxShadow(
            offset: Offset(2, 2),
            blurRadius: 8,
            color: Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  decoration: BoxDecoration(
                    color: fieldColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.w),
                      bottomLeft: Radius.circular(8.w),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                ProfileImageWidget(
                  imageProvider: NetworkImage(
                    widget.info.userImageUrl == ""
                        ? widget.info.information.imageUrl
                        : widget.info.userImageUrl,
                  ),
                  size: 36.w,
                  radius: 14.w,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        field,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                      Text(
                        widget.info.alias.isNotEmpty
                            ? widget.info.alias
                            : widget.info.information.name,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayBlack,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                formatTime(widget.info.alarm.startTime),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: primaryColor,
                    ),
              ),
              SizedBox(width: 8.w),
              GestureDetector(
                onTap: () async {
                  updateCheckBoxWithNotification();
                  setState(() {
                    isDone = !isDone;
                  });
                },
                child: Icon(
                  isDone ? Icons.check_circle : Icons.check_circle_outline,
                  size: 28.w,
                  color: fieldColor,
                ),
              ),
              SizedBox(width: 12.w),
            ],
          )
        ],
      ),
    );
  }
}
