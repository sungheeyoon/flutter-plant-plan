import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plant_plan/widgets/snapping_above.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SnappingAbove()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 160,
              ),
              Text("내 식물을 위한 플랜",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(color: const Color.fromRGBO(29, 49, 91, 1))),
              const SizedBox(
                height: 4,
              ),
              const Text("식플",
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(29, 49, 91, 1))),
              const SizedBox(
                height: 110,
              ),
              const Image(
                image: AssetImage('assets/images/splash.png'),
                width: 300,
                height: 345,
                fit: BoxFit.fill,
              )
            ],
          ),
        ),
      ),
    );
  }
}
