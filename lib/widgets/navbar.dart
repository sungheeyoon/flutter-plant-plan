import 'package:flutter/material.dart';
import 'package:plant_plan/screens/home_screen.dart';
import 'package:plant_plan/widgets/image_box.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Text(
      'Index 1: post',
      style: optionStyle,
    ),
    Text(
      'Index 2: calendar',
      style: optionStyle,
    ),
    Text(
      'Index 3: mypage',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16), topLeft: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
                color: Colors.black38.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, -2)),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? const ImageBox(
                        imageUri: "assets/icons/navbar/home_active.png",
                        width: 32,
                        height: 32)
                    : const ImageBox(
                        imageUri: "assets/icons/navbar/home.png",
                        width: 32,
                        height: 32),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? const ImageBox(
                        imageUri: "assets/icons/navbar/post_active.png",
                        width: 32,
                        height: 32)
                    : const ImageBox(
                        imageUri: "assets/icons/navbar/post.png",
                        width: 32,
                        height: 32),
                label: 'Post',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? const ImageBox(
                        imageUri: "assets/icons/navbar/calendar_active.png",
                        width: 32,
                        height: 32)
                    : const ImageBox(
                        imageUri: "assets/icons/navbar/calendar.png",
                        width: 32,
                        height: 32),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? const ImageBox(
                        imageUri: "assets/icons/navbar/mypage_active.png",
                        width: 32,
                        height: 32)
                    : const ImageBox(
                        imageUri: "assets/icons/navbar/mypage.png",
                        width: 32,
                        height: 32),
                label: 'Mypage',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
