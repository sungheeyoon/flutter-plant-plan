import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/screens/add_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 52,
                ),
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
                  "잊지 말고,",
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: primary3Color,
                      ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "내 식물에게 꼭 필요한 관리\n 까먹지 말고 사랑해주세요",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: primary3Color,
                      ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 23.h,
          ),
          Image(
            image: const AssetImage('assets/images/onbording/onbording1.png'),
            width: 540.w,
            height: 484.h,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
    // child: PageView(
    //   controller: controller,
    //   children: [
    //     OnBording(
    //       pageNum: 1,
    //       title: "잊지 말고,",
    //       sub1: "내 식물에게 꼭 필요한 관리",
    //       sub2: "까먹지 말고 사랑해주세요",
    //       controller: controller,
    //     ),
    //     OnBording(
    //       pageNum: 2,
    //       title: "알아 두고,",
    //       sub1: "내 식물을 위한 다양하고 쓸모있는 지식을",
    //       sub2: "쉽고 빠르게 알아두어 잘 자랄 수 있도록 해주세요",
    //       controller: controller,
    //     ),
    //     OnBording(
    //       pageNum: 3,
    //       title: "기억하자",
    //       sub1: "내 식물들과 함께한 시간을 기억하고",
    //       sub2: "꺼내어보며 행복했던 순간을 추억해보세요",
    //       controller: controller,
    //     ),
    //   ],
    // ),
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

class OnBording extends StatefulWidget {
  final int pageNum;
  final String title, sub1, sub2;
  final PageController controller;
  const OnBording({
    Key? key,
    required this.pageNum,
    required this.title,
    required this.sub1,
    required this.sub2,
    required this.controller,
  }) : super(key: key);

  @override
  State<OnBording> createState() => _OnBordingState();
}

class _OnBordingState extends State<OnBording> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.pageNum == 1)
                    Row(
                      children: [
                        const ImageBox(
                            imageUri: 'assets/images/onbording/long_dot.png',
                            width: 18,
                            height: 6),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(1),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(2),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        )
                      ],
                    )
                  else if (widget.pageNum == 2)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(0),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const ImageBox(
                            imageUri: 'assets/images/onbording/long_dot.png',
                            width: 18,
                            height: 6),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(2),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        )
                      ],
                    )
                  else if (widget.pageNum == 3)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(0),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => widget.controller.jumpToPage(1),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        const ImageBox(
                            imageUri: 'assets/images/onbording/long_dot.png',
                            width: 18,
                            height: 6),
                      ],
                    ),
                  TextButton(
                    child: widget.pageNum != 3
                        ? const Text(
                            "skip",
                            style: TextStyle(
                                color: Color.fromRGBO(187, 187, 187, 1)),
                          )
                        : const Text(""),
                    onPressed: () => widget.controller.jumpToPage(2),
                  )
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(widget.title,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(widget.sub1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(widget.sub2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)))
                ],
              ),
              const SizedBox(
                height: 29,
              ),
            ],
          ),
        ),
        if (widget.pageNum == 1)
          Image(
            image: const AssetImage('assets/images/onbording/onbording1.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 1.45,
            fit: BoxFit.cover,
          )
        else if (widget.pageNum == 2)
          Image(
            image: const AssetImage('assets/images/onbording/onbording2.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 1.28,
            fit: BoxFit.fill,
          )
        else if (widget.pageNum == 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Image(
                  image: const AssetImage(
                      'assets/images/onbording/onbording3.png'),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SizedBox(
                    width: 312,
                    height: 36,
                    child: OutlinedButton(
                        onPressed: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('showHome', true);

                          if (!mounted) return;
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const AddScreen()));
                        },
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
            ),
          )
      ],
    );
  }
}
