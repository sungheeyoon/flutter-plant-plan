import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/image_box.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "안시리움"),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 80),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    "\"아주 쑥쑥 자라는 중이에요\"",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
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
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              color: Colors.grey[200],
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
                                                  29, 49, 91, 1)))
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
                        imageUri: 'assets/images/management/sun_outline.png',
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
