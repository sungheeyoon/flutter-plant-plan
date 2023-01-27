import 'package:flutter/material.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "skip",
                      style: TextStyle(color: Color.fromRGBO(187, 187, 187, 1)),
                    )
                  ],
                ),
                const SizedBox(
                  height: 46,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("잊지말고,",
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(
                                color: const Color.fromRGBO(29, 49, 91, 1))),
                    const SizedBox(
                      height: 16,
                    ),
                    Text("내 식물에게 꼭 필요한 관리",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromRGBO(29, 49, 91, 1))),
                    Text("까먹지 말고 사랑해주세요",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color.fromRGBO(29, 49, 91, 1)))
                  ],
                ),
                const SizedBox(
                  height: 29,
                ),
              ],
            ),
          ),
          const Image(
            image: AssetImage('assets/images/onbording/onbording1.png'),
            width: 400,
            height: 500,
            fit: BoxFit.fill,
          )
        ],
      ),
    );
  }
}
