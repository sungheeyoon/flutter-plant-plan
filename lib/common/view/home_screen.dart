import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/home_calendar.dart';
import 'package:plant_plan/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      backgroundColor: pointColor2,
      child: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 230.h,
                child: const MyCalendar(),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(30), // 모서리 모양 변경
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30), // ClipRRect와 동일하게 설정
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(32.h), // ClipRRect와 동일하게 설정
                          color: grayColor100,
                        ),
                        height: 56.h,
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
                                Text(
                                  '15',
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
                                  '해야할 일',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: grayColor500),
                                ),
                                Text(
                                  '15',
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
                                  '해야할 일',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(color: grayColor500),
                                ),
                                Text(
                                  '15',
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
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  _currentPageIndex = 0;
                                });
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: _currentPageIndex == 0
                                    ? Colors.white
                                    : Colors.black,
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
                              child: const Text('물주기'),
                            ),
                          ),
                          Expanded(
                            child: TextButton(
                              onPressed: () {
                                _pageController.animateToPage(1,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                                setState(() {
                                  _currentPageIndex = 1;
                                });
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: _currentPageIndex == 1
                                    ? Colors.white
                                    : Colors.black,
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
                              child: const Text('분갈이'),
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
                                foregroundColor: _currentPageIndex == 2
                                    ? Colors.white
                                    : Colors.black,
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
                              child: const Text('영양제'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 300.h,
                        child: PageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          },
                          children: [
                            Container(color: Colors.blue),
                            Container(color: Colors.green),
                            Container(color: Colors.red),
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
