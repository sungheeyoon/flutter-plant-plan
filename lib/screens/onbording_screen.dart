import 'package:flutter/material.dart';
import 'package:plant_plan/screens/add_screen.dart';
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

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: [
          OnBording(
            pageNum: 1,
            title: "잊지 말고,",
            sub1: "내 식물에게 꼭 필요한 관리",
            sub2: "까먹지 말고 사랑해주세요",
            controller: controller,
          ),
          OnBording(
            pageNum: 2,
            title: "알아 두고,",
            sub1: "내 식물을 위한 다양하고 쓸모있는 지식을",
            sub2: "쉽고 빠르게 알아두어 잘 자랄 수 있도록 해주세요",
            controller: controller,
          ),
          OnBording(
            pageNum: 3,
            title: "기억하자",
            sub1: "내 식물들과 함께한 시간을 기억하고",
            sub2: "꺼내어보며 행복했던 순간을 추억해보세요",
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class OnBording extends StatelessWidget {
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
                  if (pageNum == 1)
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
                            onPressed: () => controller.jumpToPage(1),
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
                            onPressed: () => controller.jumpToPage(2),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        )
                      ],
                    )
                  else if (pageNum == 2)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => controller.jumpToPage(0),
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
                            onPressed: () => controller.jumpToPage(2),
                            icon:
                                Image.asset('assets/images/onbording/dot.png'),
                          ),
                        )
                      ],
                    )
                  else if (pageNum == 3)
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0.0),
                          width: 6.0,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => controller.jumpToPage(0),
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
                            onPressed: () => controller.jumpToPage(1),
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
                    child: pageNum != 3
                        ? const Text(
                            "skip",
                            style: TextStyle(
                                color: Color.fromRGBO(187, 187, 187, 1)),
                          )
                        : const Text(""),
                    onPressed: () => controller.jumpToPage(2),
                  )
                ],
              ),
              const SizedBox(
                height: 46,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title,
                      style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(sub1,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(sub2,
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
        if (pageNum == 1)
          const Image(
            image: AssetImage('assets/images/onbording/onbording1.png'),
            width: 380,
            height: 470,
            fit: BoxFit.fill,
          )
        else if (pageNum == 2)
          const Image(
            image: AssetImage('assets/images/onbording/onbording2.png'),
            width: 380,
            height: 470,
            fit: BoxFit.fill,
          )
        else if (pageNum == 3)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Image(
                  image: AssetImage('assets/images/onbording/onbording3.png'),
                  width: 280,
                  height: 340,
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

                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SnappingAbove()));
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
                                  builder: (context) => const AddScreen()));
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
