import 'package:flutter/material.dart';
import 'package:plant_plan/utils/colors.dart';
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
                            .copyWith(color: sub1Color),
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
                                  color: gray4Color,
                                ),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text("수분량",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(color: primaryColor)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text("95%",
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall!
                                              .copyWith(color: primaryColor)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text("12.14 19:00",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(color: gray2Color))
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
                                'assets/images/management/repotting_outline.png',
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
                          .copyWith(color: primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: point1Color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: point1Color,
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
                              .copyWith(color: grayBlack),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                        height: 78,
                        decoration: BoxDecoration(
                            color: gray5Color,
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
                                      .copyWith(color: gray1Color),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "오후 7:00",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium!
                                      .copyWith(color: grayBlack),
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
                                activeTrackColor: primaryColor.withOpacity(0.4),
                                activeColor: primaryColor),
                          ],
                        )),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "성장 TIP",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 8),
                          decoration: BoxDecoration(
                            color: sub1Color,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: sub1Color,
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
                          width: 9,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 9, vertical: 8),
                          decoration: BoxDecoration(
                            color: grayColor400,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              width: 1,
                              color: grayColor400,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "햇빛",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                          width: 1,
                          color: sub1Color,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "흙이 바싹 마르지 않게",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: grayBlack),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "빠르게 성장하는 봄~가을에는 보통 주 1~2회 겉흙이 말랐을 때에 충분히 관수를 해주세요. 안시리움은 습한 환경을 좋아하는 특성을 가지고 있기 때문에 중간중간 잎에 분무를 해주어 습도를 올려주면  좋아요. 물을 준 뒤 통풍이 잘 되는 곳에서 관리해 주세요. 통풍이 안되는 곳에서 잎에 분무를 하게 되면 검은 점이 생길 수 있으니 조심하세요.여름 장마철과 겨울에는 성장속도가 느려지기 때문에 물 주는 주기를 늘려 2주에 1번씩 주는 것이 좋아요.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: grayBlack),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Text(
                      "식집사 다이어리",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: gray5Color,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const ImageBox(
                                      imageUri: "assets/icons/emoji/smile.png",
                                      width: 24,
                                      height: 24),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "반짝반짝 빛나는",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(color: grayBlack),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                                width: 20.0,
                                child: IconButton(
                                    padding: const EdgeInsets.all(0.0),
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'assets/icons/bookmark.png')),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 8,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: const ImageBox(
                                    imageUri: 'assets/images/plants/plantA.png',
                                    width: 88,
                                    height: 88),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: const ImageBox(
                                    imageUri: 'assets/images/plants/plantA.png',
                                    width: 88,
                                    height: 88),
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        'assets/images/plants/plantA.png',
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.fill,
                                        color: Colors.black45,
                                        colorBlendMode: BlendMode.darken,
                                      ),
                                    ),
                                    Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          '+5',
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displayMedium!
                                              .copyWith(color: Colors.white),
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "새벽에 화장실 간다고 잠깐 일어났는데 너무 예뻐서... 살짝 빛 받은 모습이 진짜ㅠ 하얀색이라 어두울 때 더욱 돋보이는것 같다! 저번달만 해도 상태가 많이 안좋았는데 꾸준히 관리해준 덕분 때문일까 다시 싱그럽게 커줘서 너무 다행이다ㅠㅠㅠ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: grayBlack),
                          ),
                        ],
                      ),
                    ),
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
                            child: Text(
                              "포스트 페이지 바로가기",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge!
                                  .copyWith(color: Colors.white),
                            )),
                      ),
                    ),
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
