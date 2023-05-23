import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/view/onboarding_screen.dart';
import 'package:plant_plan/common/view/splash_screen.dart';

import 'package:plant_plan/services/notifi_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  tz.initializeTimeZones();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  final showLogin = prefs.getBool('showLogin') ?? false;

  runApp(
    ProviderScope(
      child: MyApp(showLogin: showLogin),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showLogin;

  const MyApp({
    Key? key,
    required this.showLogin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp(
          routes: {LoginScreen.routeName: (context) => const LoginScreen()},
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'Pretendard',
            textTheme: TextTheme(
              displayLarge: TextStyle(
                fontSize: 28.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.h,
              ),
              displayMedium: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -1.h,
              ),
              displaySmall: TextStyle(
                fontSize: 22.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.h,
              ),
              headlineLarge: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.h,
              ),
              headlineMedium: TextStyle(
                fontSize: 20.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.8.h,
              ),
              headlineSmall: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.7.h,
              ),
              titleLarge: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.7.h,
              ),
              titleMedium: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.6.h,
              ),
              bodyLarge: TextStyle(
                fontSize: 16.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.6.h,
              ),
              bodyMedium: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.6.h,
              ),
              bodySmall: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5.h,
              ),
              labelLarge: TextStyle(
                fontSize: 14.0.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.6.h,
              ),
              labelMedium: TextStyle(
                fontSize: 12.0.h,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5.h,
              ),
              labelSmall: TextStyle(
                fontSize: 10.0.h,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4.h,
              ),
            ),
          ),
          home: FutureBuilder<bool>(
            future: _showSplashScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData) {
                return StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const HomeScreen();
                    }
                    if (showLogin) {
                      return const LoginScreen();
                    } else {
                      return const OnboardingScreen();
                    }
                  },
                );
              } else {
                return const Text('Error');
              }
            },
          ),
        );
      },
    );
  }

  Future<bool> _showSplashScreen() async {
    await Future.delayed(const Duration(
        milliseconds: 1200)); // Display splash screen for 2 seconds
    return true; // Return true to indicate that splash screen should be skipped
  }
}
