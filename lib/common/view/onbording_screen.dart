import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/snapping_above.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBordingScreen extends StatefulWidget {
  const OnBordingScreen({super.key});

  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  final controller = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: PageView(
      children: [
        OnBordingContent(
          currentPage: 0,
          title: "잊지 말고,",
          subtitle: "내 식물에게 꼭 필요한 관리\n 까먹지 말고 사랑해주세요",
          imageTopPadding: 23.h,
          image: Image(
            image: const AssetImage('assets/images/onbording/onbording1.png'),
            width: 540.w,
            height: 484.h,
            fit: BoxFit.cover,
          ),
        ),
        OnBordingContent(
          currentPage: 1,
          title: "알아 두고,",
          subtitle: "내 식물을 위한 다양하고 쓸모있는 지식을\n 쉽고 빠르게 알아두어 잘 자랄 수 있도록 해주세요",
          imageTopPadding: 121.h,
          image: Image(
            image: const AssetImage('assets/images/onbording/onbording2.png'),
            width: 367.w,
            height: 368.h,
            fit: BoxFit.cover,
          ),
        ),
        OnBordingContent(
          currentPage: 2,
          title: "기억하자",
          subtitle: "내 식물들과 함께한 시간을 기억하고\n 꺼내어보며 행복했던 순간을 추억해보세요",
          imageTopPadding: 40.h,
          image: Image(
            image: const AssetImage('assets/images/onbording/onbording3.png'),
            width: 299.w,
            height: 351.h,
            fit: BoxFit.cover,
          ),
        ),
      ],
    ));
  }
}

class OnBordingContent extends StatelessWidget {
  final int currentPage;
  final String title;
  final String subtitle;
  final double imageTopPadding;
  final Widget image;

  const OnBordingContent({
    super.key,
    required this.currentPage,
    required this.title,
    required this.subtitle,
    required this.imageTopPadding,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        3,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Text(
                      "skip",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: gray3Color,
                          ),
                    )
                  ],
                ),
                SizedBox(
                  height: 32.h,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: primary3Color,
                      ),
                  textAlign: TextAlign.end,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primary3Color,
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
                    width: 312,
                    height: 36,
                    child: OutlinedButton(
                        onPressed: () async {},
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              width: 0, color: Color.fromRGBO(255, 133, 63, 1)),
                          backgroundColor:
                              const Color.fromRGBO(255, 133, 63, 1),
                        ),
                        child: Text(
                          "내 식물 추가하기",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Center(
                  child: SizedBox(
                    width: 312,
                    height: 36,
                    child: OutlinedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SnappingAbove()));
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          side: const BorderSide(
                              width: 1, color: Color.fromRGBO(255, 133, 63, 1)),
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          "메인화면 바로가기",
                          style:
                              TextStyle(color: Color.fromRGBO(255, 133, 63, 1)),
                        )),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }

  AnimatedContainer buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 18 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? primary3Color : gray3Color,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
