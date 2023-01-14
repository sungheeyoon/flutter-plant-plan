import 'package:flutter/material.dart';
import 'package:plant_plan/models/toon_model.dart';
import 'package:plant_plan/services/api_service.dart';
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
                          height: 186,
                          color: Colors.white,
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
