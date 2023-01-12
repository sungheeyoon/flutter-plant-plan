import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/image_box.dart';

class DummyContent extends StatelessWidget {
  final bool reverse;
  final ScrollController? controller;

  const DummyContent({Key? key, this.controller, this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 62),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "현재 전체적인 식물 상태",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  ImageBox(imageUri: 'assets/images/humid_outline.png'),
                  SizedBox(
                    width: 10,
                  ),
                  ImageBox(imageUri: 'assets/images/sun_outline.png'),
                  SizedBox(
                    width: 10,
                  ),
                  ImageBox(imageUri: 'assets/images/division_outline.png'),
                  SizedBox(
                    width: 10,
                  ),
                  ImageBox(imageUri: 'assets/images/nutrient_outline.png')
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(children: const [
                SnappingContainer(
                    imageUrl: "assets/images/humid.png",
                    title: "수분량",
                    measure: "88%",
                    explain: "모든 식물이들 수분 충분해요"),
                SizedBox(
                  width: 10,
                ),
                SnappingContainer(
                    imageUrl: "assets/images/sun.png",
                    title: "일조량",
                    measure: "75%",
                    explain: "모든 식물이들 일조량 충분해요"),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(children: const [
                SnappingContainer(
                    imageUrl: "assets/images/division.png",
                    title: "분갈이",
                    measure: "D-120",
                    explain: "분갈이 시기 확인하세요"),
                SizedBox(
                  width: 10,
                ),
                SnappingContainer(
                    imageUrl: "assets/images/nutrient.png",
                    title: "영양제",
                    measure: "D-80",
                    explain: "영양제 종류/목적 중요해요")
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class SnappingContainer extends StatelessWidget {
  final String imageUrl, title, measure, explain;
  const SnappingContainer({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.measure,
    required this.explain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 91,
      width: 150,
      child: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(245, 245, 245, 1),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  Image(
                    image: AssetImage(imageUrl),
                    height: 20,
                    width: 20,
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text("평균", style: TextStyle(fontSize: 12)),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(measure,
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w700))
                    ],
                  ),
                  Text(
                    explain,
                    style: const TextStyle(
                        fontSize: 10, color: Color.fromRGBO(148, 148, 148, 1)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
