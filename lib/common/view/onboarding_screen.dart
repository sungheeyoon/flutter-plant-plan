import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
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
                        prefs.setBool('showHome', true);
                        if (context.mounted) {
                          GoRouter.of(context).go('/login');
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
