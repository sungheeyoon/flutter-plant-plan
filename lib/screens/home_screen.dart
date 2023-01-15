import 'package:flutter/material.dart';
import 'package:plant_plan/models/toon_model.dart';
import 'package:plant_plan/services/api_service.dart';
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
            padding: const EdgeInsets.fromLTRB(24, 140, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "More Plants,",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 32),
                ),
                Text("More Happiness",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 32)),
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
                                    imageUri: 'assets/images/humid_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri: 'assets/images/sun_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri:
                                        'assets/images/division_outline.png',
                                    width: 48,
                                    height: 48,
                                  ),
                                  SizedBox(
                                    width: 24,
                                  ),
                                  ImageBox(
                                    imageUri:
                                        'assets/images/nutrient_outline.png',
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
