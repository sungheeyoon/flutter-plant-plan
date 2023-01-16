import 'package:flutter/material.dart';
import 'package:plant_plan/models/toon_model.dart';
import 'package:plant_plan/services/api_service.dart';
import 'package:plant_plan/widgets/clear_card.dart';
import 'package:plant_plan/widgets/image_box.dart';
import 'package:plant_plan/widgets/round_image_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<ToonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 128, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "More Plants,",
                  style: TextStyle(
                      fontFamily: "PyeongChangPeace",
                      fontWeight: FontWeight.w300,
                      fontSize: 32,
                      color: Color.fromRGBO(29, 49, 91, 1)),
                ),
                Text("More Happiness",
                    style: TextStyle(
                        fontFamily: "PyeongChangPeace",
                        fontWeight: FontWeight.w300,
                        fontSize: 32,
                        color: Color.fromRGBO(29, 49, 91, 1))),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                color: const Color.fromRGBO(235, 247, 232, 1),
                height: 328,
                child: Column(
                  children: [
                    FutureBuilder(
                      future: webtoons,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                            child: Column(
                              children: [Expanded(child: makeList(snapshot))],
                            ),
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 24),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          height: 186,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    "안시리움",
                                    style: TextStyle(
                                        color: Color.fromRGBO(29, 49, 91, 1),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "20.05.17",
                                    style: TextStyle(
                                        color: Color.fromRGBO(187, 187, 187, 1),
                                        fontSize: 12),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  ImageBox(
                                    imageUri:
                                        'assets/images/management/humid_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri:
                                        'assets/images/management/sun_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri:
                                        'assets/images/management/division_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri:
                                        'assets/images/management/nutrient_outline.png',
                                    width: 48,
                                    height: 48,
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "\"아주 쑥쑥 자라는 중이에요\"",
                                style: TextStyle(
                                    color: Color.fromRGBO(146, 205, 141, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text(
                                "자세히 보기",
                                style: TextStyle(
                                    color: Color.fromRGBO(165, 165, 165, 1),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    const Text(
                      "곧 다가오는 내 식물 관리",
                      style: TextStyle(
                          color: Color.fromRGBO(29, 49, 91, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const ClearCard(
                        imageUri:
                            'assets/images/management/nutrient_outline.png',
                        title: '인도고무나무',
                        action: '물 주기',
                        day: '8.15(일)',
                        time: '13:00',
                        dayBool: true,
                        clear: true),
                    const SizedBox(
                      height: 12,
                    ),
                    const ClearCard(
                        imageUri:
                            'assets/images/management/nutrient_outline.png',
                        title: '인도고무나무',
                        action: '물 주기',
                        day: '8.15(일)',
                        time: '13:00',
                        dayBool: false,
                        clear: false),
                    const SizedBox(
                      height: 12,
                    ),
                    const ClearCard(
                        imageUri:
                            'assets/images/management/nutrient_outline.png',
                        title: '인도고무나무',
                        action: '물 주기',
                        day: '8.15(일)',
                        time: '13:00',
                        dayBool: false,
                        clear: true),
                    const SizedBox(
                      height: 12,
                    ),
                    const ClearCard(
                        imageUri:
                            'assets/images/management/nutrient_outline.png',
                        title: '인도고무나무',
                        action: '물 주기',
                        day: '8.15(일)',
                        time: '13:00',
                        dayBool: true,
                        clear: false),
                    const SizedBox(
                      height: 32,
                    ),
                    Center(
                      child: SizedBox(
                        width: 200,
                        height: 40,
                        child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              side: const BorderSide(
                                  width: 0,
                                  color: Color.fromRGBO(192, 220, 185, 1)),
                              backgroundColor:
                                  const Color.fromRGBO(192, 220, 185, 1),
                            ),
                            child: const Text(
                              "전체보기",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.white),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    )
                  ],
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text(
                    "오늘의 날씨",
                    style: TextStyle(
                        color: Color.fromRGBO(29, 49, 91, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 22,
                          width: 60,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(244, 244, 244, 1),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Center(
                            child: Text(
                              "26° / 16°",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(136, 138, 143, 1)),
                            ),
                          )),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ImageBox(
                          imageUri: 'assets/images/weather/partly_sunny.png',
                          width: 80,
                          height: 80),
                      const SizedBox(
                        width: 24,
                      ),
                      Column(
                        children: const [
                          Text(
                            "22°",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 40,
                                color: Color.fromRGBO(29, 49, 91, 1)),
                          ),
                          Text(
                            "강수확률30% 습도60%",
                            style: TextStyle(
                                fontSize: 10,
                                color: Color.fromRGBO(29, 49, 91, 1)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Center(
                    child: Text(
                      '햇빛이 적당히 필요한 식물에게 좋은 날이에요!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16, color: Color.fromRGBO(29, 49, 91, 1)),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }

  ListView makeList(AsyncSnapshot<List<ToonModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length + 1,
      padding: const EdgeInsets.fromLTRB(24, 20, 0, 0),
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        if (index == 0) {
          return Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 1,
                    color: const Color.fromRGBO(170, 226, 177, 1),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "+",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w100,
                          color: Color.fromRGBO(170, 226, 177, 1)),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                "",
                style: TextStyle(fontSize: 12),
              )
            ],
          );
        }
        return RoundImage(thumb: webtoon.thumb, id: webtoon.id);
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 16,
      ),
    );
  }
}
