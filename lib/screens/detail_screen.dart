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
                    children: const [
                      ImageBox(
                        imageUri: 'assets/images/management/humid_outline.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ImageBox(
                        imageUri: 'assets/images/management/sun_outline.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ImageBox(
                        imageUri:
                            'assets/images/management/division_outline.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ImageBox(
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
