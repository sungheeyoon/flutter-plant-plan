import 'package:flutter/material.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/utils/colors.dart';

class RootTab extends StatefulWidget {
  static String get routeName => 'home';

  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController controller;

  int index = 0;

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);

    controller.addListener(tabListener);
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

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.black12,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        onTap: (int index) {
          controller.animateTo(index);
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
          const BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/navbar/calendar.png',
              width: 30,
              height: 30,
            ),
            activeIcon: Image.asset(
              'assets/icons/navbar/calendar_active.png',
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
        children: const [
          HomeScreen(),
          Text('asd'),
          Text('asd'),
          Text('asdasd'),
          Text('asdasdsad'),
        ],
      ),
    );
  }
}
