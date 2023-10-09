import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/plants_model.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/common/view/splash_screen.dart';
import 'package:plant_plan/diary/view/diary_screen.dart';
import 'package:plant_plan/list/provider/list_delete_mode_provider.dart';
import 'package:plant_plan/list/view/list_screen.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/my_page/view/my_page_screen.dart';
import 'package:plant_plan/services/local_notification_service.dart';
import 'package:plant_plan/utils/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'root';
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => RootTabState();
}

class RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;
  bool isFavoriteForListScreen = false;
  bool isBookMarkForDiaryScreen = false;
  LocalNotificationService notificationService = LocalNotificationService();

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);

    _fetchPlants();
  }

  @override
  void dispose() {
    controller.removeListener(tabListener);

    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = controller.index;
    });
  }

  void navigateToFavoriteListScreen() {
    int listScreenIndex = 1;

    setState(() {
      isFavoriteForListScreen = true;
      controller.animateTo(listScreenIndex);
    });
  }

  void navigateToBookMarkDiaryScreen() {
    int diaryScreenIndex = 3;

    setState(() {
      isBookMarkForDiaryScreen = true;
      controller.animateTo(diaryScreenIndex);
    });
  }

  Future<void> _fetchPlants() async {
    await ref.read(plantsProvider.notifier).fetchPlants();
  }

  Future<void> scheduleNotifications(List<PlantModel> plants) async {
    await notificationService.deleteAllNotifications();
    for (final plant in plants) {
      for (final alarm in plant.alarms) {
        await notificationService.scheduleAlarmNotification(alarm);
      }
    }
  }

  Future<void> scheduleTestAlarm(
      LocalNotificationService notificationService) async {
    // 현재 시간으로부터 5초 뒤에 알람 설정
    DateTime now = DateTime.now();
    DateTime scheduledTime = now.add(const Duration(hours: 1));

    // 포맷 변경 (시간을 "hh:mm a" 형식으로 표시)
    String formattedTime = DateFormat.jm().format(scheduledTime);

    // 알람 설정
    await notificationService.scheduleAlarmNotification(
      AlarmModel(
        id: 'test_alarm',
        field: PlantField.watering, // 예시로 물주기 알림 설정
        startTime: scheduledTime,
        repeat: 0,
        offDates: [], // 예시로 비어 있는 offDates 설정
        isOn: true,
        title: 'Test Alarm',
      ),
    );
    List<PendingNotificationRequest> notifications =
        await notificationService.retrievePendingNotifications();
    for (var notification in notifications) {
      print('Notification ID: ${notification.id}');
      print('Notification Title: ${notification.title}');
      print('Notification Body: ${notification.body}');
      print('Notification Payload: ${notification.payload}');
      print('--------------------------------------------------');
    }

    print('Test alarm scheduled for: $formattedTime');
  }

  @override
  Widget build(BuildContext context) {
    final PlantsModelBase plantsState = ref.watch(plantsProvider);

    if (plantsState is PlantsModelLoading) {
      return const SplashScreen();
    } else if (plantsState is PlantsModelError) {
      return ErrorScreen(errorMessage: plantsState.message);
    } else if (plantsState is PlantsModel) {
      final List<PlantModel> plants = plantsState.data;
      final bool listDeleteModeState = ref.watch(listDeleteModeProvider);
      scheduleNotifications(plants);
      scheduleTestAlarm(notificationService);
      return DefaultLayout(
        bottomNavigationBar: listDeleteModeState
            ? null
            : BottomNavigationBar(
                backgroundColor: Colors.white,
                selectedItemColor: primaryColor,
                unselectedItemColor: Colors.black12,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                onTap: (int tappedIndex) {
                  if (tappedIndex == 2) {
                    // Icon(Icons.add)를 눌렀을 때
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const SearchScreen();
                      },
                    ));
                  } else {
                    setState(() {
                      index = tappedIndex;
                      controller.animateTo(tappedIndex);
                    });
                  }
                  if (tappedIndex != 1) {
                    isFavoriteForListScreen = false;
                  }
                  if (tappedIndex != 3) {
                    isBookMarkForDiaryScreen = false;
                  }
                },
                currentIndex: index,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/navbar/home.png',
                      width: 30,
                      height: 30,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/navbar/home_active.png',
                      width: 30,
                      height: 30,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/navbar/pot.png',
                      width: 30,
                      height: 30,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/navbar/pot_active.png',
                      width: 30,
                      height: 30,
                    ),
                    label: '',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/navbar/post.png',
                      width: 30,
                      height: 30,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/navbar/post_active.png',
                      width: 30,
                      height: 30,
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      'assets/icons/navbar/mypage.png',
                      width: 30,
                      height: 30,
                    ),
                    activeIcon: Image.asset(
                      'assets/icons/navbar/mypage_active.png',
                      width: 30,
                      height: 30,
                    ),
                    label: '',
                  ),
                ],
                selectedLabelStyle: const TextStyle(height: 0),
              ),
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            HomeScreen(plants: plants),
            ListScreen(
              plants: plants,
              favorite: isFavoriteForListScreen,
            ),
            const Text('asd'),
            DiaryScreen(
              plants: plants,
              bookMark: isBookMarkForDiaryScreen,
            ),
            MyPageScreen(plants: plants),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
