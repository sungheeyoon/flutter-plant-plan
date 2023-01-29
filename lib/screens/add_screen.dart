import 'package:flutter/material.dart';
import 'package:plant_plan/screens/snapping_screen.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/image_box.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "식물추가",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: const [
                        ImageBox(
                            imageUri: 'assets/images/pot.png',
                            width: 80,
                            height: 80),
                        ImageBox(
                            imageUri: 'assets/icons/img.png',
                            width: 20,
                            height: 20)
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 180,
                      child: TextField(
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromRGBO(29, 49, 91, 1)),
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          suffixIconConstraints:
                              BoxConstraints(minHeight: 20, minWidth: 20),
                          suffixIcon: ImageBox(
                              imageUri: "assets/icons/search.png",
                              width: 1,
                              height: 1),
                          isCollapsed: true,
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                          hintText: '식물 이름 검색',
                          hintStyle:
                              TextStyle(color: Color.fromRGBO(29, 49, 91, 1)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: Color.fromRGBO(29, 49, 91, 1)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(children: const [
                      SnappingContainer(
                          imageUrl: "assets/images/management/humid.png",
                          title: "수분량",
                          measure: "88%",
                          explain: "모든 식물이들 수분 충분해요"),
                      SizedBox(
                        width: 10,
                      ),
                      SnappingContainer(
                          imageUrl: "assets/images/management/sun.png",
                          title: "일조량",
                          measure: "75%",
                          explain: "모든 식물이들 일조량 충분해요"),
                    ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(children: const [
                      SnappingContainer(
                          imageUrl: "assets/images/management/division.png",
                          title: "분갈이",
                          measure: "D-120",
                          explain: "분갈이 시기 확인하세요"),
                      SizedBox(
                        width: 10,
                      ),
                      SnappingContainer(
                          imageUrl: "assets/images/management/nutrient.png",
                          title: "영양제",
                          measure: "D-80",
                          explain: "영양제 종류/목적 중요해요")
                    ])
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text("주기 설정",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(
                              color: const Color.fromRGBO(29, 49, 91, 1))),
                  const SizedBox(
                    height: 16,
                  ),
                  const SettingCard(title: "물주기"),
                  const SizedBox(
                    height: 21,
                  ),
                  const SettingCard(title: "분갈이"),
                  const SizedBox(
                    height: 21,
                  ),
                  const SettingCard(title: "영양제"),
                  const SizedBox(
                    height: 141,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingCard extends StatelessWidget {
  final String title;
  const SettingCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: 22,
              width: 53,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 133, 63, 1),
                borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(10), left: Radius.circular(10)),
                border: Border.all(
                  width: 1,
                  color: const Color.fromRGBO(255, 133, 63, 1),
                ),
              ),
              child: Center(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            SizedBox(
              width: 240,
              child: TextField(
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 20, minWidth: 20),
                  suffixIcon: ImageBox(
                      imageUri: "assets/icons/pen.png", width: 1, height: 1),
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1, color: Color.fromRGBO(29, 49, 91, 1)),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
            height: 80,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(245, 245, 245, 1),
                borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Text("$title 알람을 설정하세요"),
            )),
      ],
    );
  }
}
