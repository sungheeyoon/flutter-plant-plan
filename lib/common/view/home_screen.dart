import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/userInfoProvider.dart';
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
    final userInfo = ref.watch(userInfoProvider);
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
                borderRadius: BorderRadius.circular(30), // 모서리 모양 변경
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(30), // ClipRRect와 동일하게 설정
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
                            ), // ClipRRect와 동일하게 설정
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
                                    '100%',
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
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5개의 일정이 있어요',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: const Color(0xFF72CBE7),
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    const AlarmCard(
                                        field: PlantField.watering,
                                        isDone: true,
                                        name: "앗싸라말라잌",
                                        time: "12:00 PM",
                                        imgUrl:
                                            'assets/icons/home/change_view.png')
                                  ],
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '5개의 일정이 있어요',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: const Color(0xFF72CBE7),
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    const AlarmCard(
                                        field: PlantField.repotting,
                                        isDone: true,
                                        name: "앗싸라말라잌",
                                        time: "12:00 PM",
                                        imgUrl:
                                            'assets/icons/home/change_view.png')
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Text('$userInfo'),
                            ),
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
  _AlarmCardState createState() => _AlarmCardState();
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
