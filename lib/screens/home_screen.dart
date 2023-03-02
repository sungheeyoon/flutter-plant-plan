import 'package:flutter/material.dart';
import 'package:plant_plan/models/toon_model.dart';
import 'package:plant_plan/screens/add_screen.dart';
import 'package:plant_plan/services/api_service.dart';
import 'package:plant_plan/widgets/image_box.dart';
import 'package:plant_plan/widgets/management_widget.dart';
import 'package:plant_plan/widgets/round_image_widget.dart';
import 'package:plant_plan/widgets/weather_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> weathers = [
    {'img': 'assets/images/weather/partly_sunny.png', 'time': '11:00'},
    {'img': 'assets/images/weather/partly_sunny.png', 'time': '12:00'},
    {'img': 'assets/images/weather/cloudy.png', 'time': '13:00'},
    {'img': 'assets/images/weather/cloudy.png', 'time': '14:00'},
    {'img': 'assets/images/weather/sunny.png', 'time': '15:00'},
    {'img': 'assets/images/weather/sunny.png', 'time': '16:00'},
    {'img': 'assets/images/weather/partly_sunny.png', 'time': '17:00'},
    {'img': 'assets/images/weather/sunny.png', 'time': '18:00'},
    {'img': 'assets/images/weather/partly_sunny.png', 'time': '19:00'},
    {'img': 'assets/images/weather/cloudy.png', 'time': '20:00'},
    {'img': 'assets/images/weather/partly_sunny.png', 'time': '21:00'},
  ];
  List<String> likeList = ['0', '0', '0', '0', '0', '0'];
  late SharedPreferences prefs;
  final Future<List<ToonModel>> webtoons = ApiService.getTodaysToons();

  Future initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    final List<String>? likedPosts = prefs.getStringList('likedPosts');
    if (likedPosts == null) {
      await prefs.setStringList('likedPosts', likeList);
    } else {
      setState(() {
        likeList = prefs.getStringList('likedPosts') ?? [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initPrefs();
  }

  onHeartTap(int idx) async {
    prefs = await SharedPreferences.getInstance();
    if (likeList[idx] == '0') {
      setState(() {
        likeList[idx] = '1';
      });
    } else {
      setState(() {
        likeList[idx] = '0';
      });
    }
    await prefs.setStringList('likedPosts', likeList);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
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
                    return Column(
                      children: const [
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                      ],
                    );
                  },
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "안시리움",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: const Color.fromRGBO(
                                            29, 49, 91, 1)),
                              ),
                              Text(
                                "20. 05. 17",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: const Color.fromRGBO(
                                            187, 187, 187, 1)),
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
                          Text(
                            "\"아주 쑥쑥 자라는 중이에요\"",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color:
                                        const Color.fromRGBO(146, 205, 141, 1)),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "자세히 보기",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    color:
                                        const Color.fromRGBO(187, 187, 187, 1)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Management(),
          const SizedBox(
            height: 80,
          ),
          Weather(weathers: weathers),
          const SizedBox(
            height: 80,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Text(
                      "식플 BEST 포스트",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: const Color.fromRGBO(29, 49, 91, 1)),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GridView.count(
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height / 1.65),
                  physics: const ScrollPhysics(),
                  crossAxisSpacing: 8.0,
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(6, (index) {
                    return Column(
                      children: [
                        Container(
                          width: 152,
                          height: 132,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/images/plants/plantA.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                              width: 152,
                              height: 24,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(8)),
                                color: Color.fromRGBO(2, 2, 2, 0.7),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 6),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "내 식물을 위해 알아야할 TIP",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: Colors.white),
                                      ),
                                      IconButton(
                                        iconSize: 16,
                                        padding: EdgeInsets.zero, // 패딩 설정
                                        constraints: const BoxConstraints(),
                                        onPressed: () => onHeartTap(index),
                                        icon: likeList[index] == "1"
                                            ? Image.asset(
                                                "assets/icons/favorite.png")
                                            : Image.asset(
                                                "assets/icons/favorite_outline.png"),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "요즘 식집사 생활엔 식물등이asd김김김김김sad갬",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: const Color.fromRGBO(29, 49, 91, 1),
                                  ),
                        )
                      ],
                    );
                  }),
                ),
              ),
              const SizedBox(
                height: 15,
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
                            width: 0, color: Color.fromRGBO(192, 220, 185, 1)),
                        backgroundColor: const Color.fromRGBO(192, 220, 185, 1),
                      ),
                      child: Text(
                        "포스트 페이지 바로가기",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(
                height: 84,
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
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddScreen(),
                      ));
                },
                child: Container(
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
                  child: const Text(
                    "+",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w100,
                        color: Color.fromRGBO(170, 226, 177, 1)),
                  ),
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
