import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/model/plants_model.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/common/view/splash_screen.dart';
import 'package:plant_plan/list/view/list_screen.dart';
import 'package:plant_plan/utils/colors.dart';

class RootTab extends ConsumerStatefulWidget {
  static String get routeName => 'home';
  const RootTab({super.key});

  @override
  ConsumerState<RootTab> createState() => _RootTabState();
}

class _RootTabState extends ConsumerState<RootTab>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int index = 0;

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

  Future<void> _fetchPlants() async {
    await ref.read(plantsProvider.notifier).fetchPlants();
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

      return DefaultLayout(
        bottomNavigationBar: BottomNavigationBar(
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
            ListScreen(plants: plants),
            const Text('asd'),
            const Text('asdasd'),
            const Text('asdasdsad'),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
