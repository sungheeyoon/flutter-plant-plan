import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/image_box.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "안시리움"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 32, 24, 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "\"아주 쑥쑥 자라는 중이에요\"",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(
                                color: const Color.fromRGBO(146, 205, 141, 1)),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      const CircleAvatar(
                        radius: 60, // Image radius
                        backgroundImage:
                            AssetImage("assets/images/plants/plantA.png"),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const ImageBox(
                                imageUri:
                                    'assets/images/management/humid_outline.png',
                                width: 70,
                                height: 70,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                height: 80,
                                width: 68,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  color: Color.fromRGBO(245, 245, 245, 1),
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text("수분량",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                  color: const Color.fromRGBO(
                                                      29, 49, 91, 1))),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text("95%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(
                                                  color: const Color.fromRGBO(
                                                      29, 49, 91, 1))),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text("12.14 19:00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: const Color.fromRGBO(
                                                      187, 187, 187, 1)))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const ImageBox(
                            imageUri:
                                'assets/images/management/sun_outline.png',
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const ImageBox(
                            imageUri:
                                'assets/images/management/division_outline.png',
                            width: 70,
                            height: 70,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const ImageBox(
                            imageUri:
                                'assets/images/management/nutrient_outline.png',
                            width: 70,
                            height: 70,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "주기설정",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          height: 28,
                          width: 60,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(255, 133, 63, 1),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: const Color.fromRGBO(255, 133, 63, 1),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "물주기",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "여름철 - 주 1회 (겉흙이 말랐는지 확인 필수)",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: const Color.fromRGBO(2, 2, 2, 1)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        height: 78,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(248, 248, 248, 1),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "매주 일요일",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                          color: const Color.fromRGBO(
                                              95, 95, 95, 1)),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "오후 7:00",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(
                                          color:
                                              const Color.fromRGBO(2, 2, 2, 1)),
                                )
                              ],
                            ),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeTrackColor:
                                  const Color.fromRGBO(29, 49, 91, 0.4),
                              activeColor: const Color.fromRGBO(29, 49, 91, 1),
                            ),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
