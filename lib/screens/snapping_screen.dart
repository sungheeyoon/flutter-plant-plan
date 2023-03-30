import 'package:flutter/material.dart';

class SnappingScreen extends StatelessWidget {
  final bool? reverse;
  final ScrollController? controller;

  const SnappingScreen({Key? key, this.controller, this.reverse = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "현재 전체적인 식물 상태",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
                ),
                const SizedBox(
                  height: 32,
                ),
                const Row(children: [
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
                const Row(children: [
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
                ]),
                const SizedBox(
                  height: 10,
                ),
                const Row(children: [
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
      height: 78,
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
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
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
                      Text(
                        "평균",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: const Color.fromRGBO(29, 49, 91, 1)),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        measure,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: const Color.fromRGBO(29, 49, 91, 1)),
                      )
                    ],
                  ),
                  Text(
                    explain,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: const Color.fromRGBO(95, 95, 95, 1)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
