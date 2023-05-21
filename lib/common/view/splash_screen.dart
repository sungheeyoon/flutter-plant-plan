import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class SplashScreen extends StatefulWidget {
  static String get routeName => 'splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Timer(const Duration(milliseconds: 1500), () {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => SnappingAbove()));
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: DefaultLayout(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 160.h,
              ),
              Text(
                "내 식물을 위한 플랜",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: primaryColor,
                    ),
              ),
              const Text(
                "식플 ",
                style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                    height: 0),
              ),
              SizedBox(
                height: 106.h,
              ),
              Expanded(
                child: Image(
                  image: const AssetImage('assets/images/splash.png'),
                  width: 312.w,
                  height: 400.h,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
