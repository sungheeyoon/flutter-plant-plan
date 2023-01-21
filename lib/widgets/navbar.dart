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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageBox(
                imageUri: "assets/icons/navbar/home.png",
                width: 32,
                height: 32),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageBox(
                imageUri: "assets/icons/navbar/post.png",
                width: 32,
                height: 32),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: ImageBox(
                imageUri: "assets/icons/navbar/calendar.png",
                width: 32,
                height: 32),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: ImageBox(
                imageUri: "assets/icons/navbar/mypage.png",
                width: 32,
                height: 32),
            label: 'My Page',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
