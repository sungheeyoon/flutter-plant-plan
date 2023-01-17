import 'package:flutter/cupertino.dart';
import 'package:plant_plan/widgets/image_box.dart';

class Weather extends StatelessWidget {
  const Weather({
    Key? key,
    required this.weathers,
  }) : super(key: key);

  final List<Map<String, String>> weathers;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            fontSize: 10, color: Color.fromRGBO(29, 49, 91, 1)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        const Center(
          child: Text(
            '햇빛이 적당히 필요한 식물에게 좋은 날이에요!',
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 16, color: Color.fromRGBO(29, 49, 91, 1)),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        SizedBox(
          height: 62,
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
                        children: const [
                          SizedBox(
                            width: 24,
                          ),
                          ImageBox(
                              imageUri:
                                  'assets/images/weather/partly_sunny.png',
                              width: 48,
                              height: 48),
                          Text(
                            '13:00',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(29, 49, 91, 1),
                            ),
                          )
                        ],
                      );
                    }
                    return Column(
                      children: const [
                        ImageBox(
                            imageUri: 'assets/images/weather/partly_sunny.png',
                            width: 48,
                            height: 48),
                        Text(
                          '13:00',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(29, 49, 91, 1),
                          ),
                        )
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 16,
                  ),
                  itemCount: weathers.length,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
