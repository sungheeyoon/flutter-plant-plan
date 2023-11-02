import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  static String get routeName => 'onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController controller;
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 화면이 렌더링된 후 모달창을 띄우기 위한 콜백
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            contentPadding: const EdgeInsets.all(0),
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              width: 280,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Text(
                        '앱 접근 권한 안내',
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: grayBlack,
                                ),
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Center(
                      child: Text(
                        '식플의 서비스를 이용하기 위해',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '다음 권한들을 확인해 주시기 바랍니다',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: grayColor300,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '선택적 접근 권한',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: grayBlack,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Image(
                          image:
                              AssetImage('assets/icons/permission/alarm.png'),
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '알림',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: primaryColor,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '컨텐츠 알림을 위한 권한',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: grayColor600,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Image(
                          image:
                              AssetImage('assets/icons/permission/camera.png'),
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '카메라',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: primaryColor,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '카메라 알림을 위한 권한',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: grayColor600,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Image(
                          image:
                              AssetImage('assets/icons/permission/picture.png'),
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '사진 라이브러리',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: primaryColor,
                                  ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              '파일 및 이미지 첨부를 위한 권한',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: grayColor600,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Divider(
                      color: grayColor300,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '선택적 접근 권한은 해당 기능을 사용할 때 허용이 필요하며, 허용하지 않아도 해당 기능 외 서비스 이용이 가능합니다',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: grayColor500,
                          ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      '접근 권한 변경 방법 :  휴대폰 설정 > 식플',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: grayColor500,
                          ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 42)), // 최대 너비 설정
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(pointColor2),
                      ),
                      child: Text(
                        '확인',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });

    return DefaultLayout(
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 22.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => buildDot(index: index),
                          ),
                        ),
                        if (currentIndex != 2)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                currentIndex = 2;
                                controller.jumpToPage(2);
                              });
                            },
                            child: Text(
                              "skip",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: grayColor400,
                                  ),
                            ),
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: PageView(
              onPageChanged: onchahged,
              controller: controller,
              children: [
                OnboardingContent(
                  controller: controller,
                  currentPage: 0,
                  title: "잊지 말고,",
                  subtitle: "내 식물에게 꼭 필요한 관리\n 까먹지 말고 사랑해주세요",
                  imageTopPadding: 23.h,
                  image: Image(
                    image: const AssetImage(
                        'assets/images/onboarding/onboarding1.png'),
                    width: 455.w,
                    height: 484.h,
                    fit: BoxFit.contain,
                  ),
                ),
                OnboardingContent(
                  controller: controller,
                  currentPage: 1,
                  title: "알아 두고,",
                  subtitle: "내 식물을 위한 다양한 지식을 알아두어\n 잘 자랄 수 있도록 해주세요",
                  imageTopPadding: 121.h,
                  image: Image(
                    image: const AssetImage(
                        'assets/images/onboarding/onboarding2.png'),
                    width: 367.w,
                    height: 368.h,
                    fit: BoxFit.contain,
                  ),
                ),
                OnboardingContent(
                  controller: controller,
                  currentPage: 2,
                  title: "기억하자",
                  subtitle: "내 식물들과 함께한 시간을 기억하고\n  행복했던 순간을 추억해보세요",
                  imageTopPadding: 40.h,
                  image: Image(
                    image: const AssetImage(
                        'assets/images/onboarding/onboarding3.png'),
                    width: 299.w,
                    height: 351.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 18 : 6,
      decoration: BoxDecoration(
        color: currentIndex == index ? primaryColor : grayColor400,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }

  onchahged(int index) {
    setState(() {
      currentIndex = index;
    });
  }
}

class OnboardingContent extends StatelessWidget {
  final int currentPage;
  final PageController controller;
  final String title;
  final String subtitle;
  final double imageTopPadding;
  final Widget image;

  const OnboardingContent({
    super.key,
    required this.controller,
    required this.currentPage,
    required this.title,
    required this.subtitle,
    required this.imageTopPadding,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 32.h,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: primaryColor,
                    ),
                textAlign: TextAlign.end,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: primaryColor,
                    ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        SizedBox(
          height: imageTopPadding,
        ),
        image,
        if (currentPage == 2)
          Column(
            children: [
              SizedBox(
                height: 43.h,
              ),
              Center(
                child: SizedBox(
                  width: 312.w,
                  height: 36.h,
                  child: OutlinedButton(
                      onPressed: () async {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showLogin', true);
                        if (context.mounted) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginScreen()),
                              (route) => false);
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: const BorderSide(
                          width: 0,
                          color: pointColor1,
                        ),
                        backgroundColor: pointColor1,
                      ),
                      child: Text(
                        "시작하기",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      )),
                ),
              ),
            ],
          )
      ],
    );
  }
}
