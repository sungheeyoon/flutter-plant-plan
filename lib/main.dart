import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:plant_plan/common/const/data.dart';
import 'package:plant_plan/common/view/login_screen.dart';
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
  final showHome = prefs.getBool('showHome') ?? false;
  KakaoSdk.init(nativeAppKey: NATIVE_APP_KEY);
  final origin = await KakaoSdk.origin;
  print('오리진 오리진 오리진$origin');

  runApp(
    ProviderScope(
      child: MyApp(showHome: showHome),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool showHome;

  const MyApp({
    Key? key,
    required this.showHome,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp(
            // localizationsDelegates: const [
            //   // ... app-specific localization delegate[s] here
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: const [
            //   Locale('ko', 'KR'),
            // ],
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Pretendard',
              textTheme: TextTheme(
                displayLarge: TextStyle(
                  fontSize: 28.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.sp,
                ),
                displayMedium: TextStyle(
                  fontSize: 24.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.sp,
                ),
                displaySmall: TextStyle(
                  fontSize: 22.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.sp,
                ),
                headlineLarge: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.sp,
                ),
                headlineMedium: TextStyle(
                  fontSize: 20.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.8.sp,
                ),
                headlineSmall: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.7.sp,
                ),
                titleLarge: TextStyle(
                  fontSize: 18.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.7.sp,
                ),
                titleMedium: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6.sp,
                ),
                bodyLarge: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.6.sp,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6.sp,
                  height: 1.5.sp,
                ),
                bodySmall: TextStyle(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5.sp,
                ),
                labelLarge: TextStyle(
                  fontSize: 14.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.6.sp,
                ),
                labelMedium: TextStyle(
                  fontSize: 12.0.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5.sp,
                ),
                labelSmall: TextStyle(
                  fontSize: 10.0.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4.sp,
                ),
              ).apply(
                decorationColor: Colors.orange,
              ),
            ),
            home: const LoginScreen()
            //showHome ? SnappingAbove() : const OnboardingScreen(),
            );
      },
    );
  }
}
