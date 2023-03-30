import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:plant_plan/common/const/data.dart';
import 'package:plant_plan/services/notifi_service.dart';
import 'package:plant_plan/widgets/snapping_above.dart';
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
  //해시 키
  //final origin = await KakaoSdk.origin;

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
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
                displayMedium: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1,
                ),
                displaySmall: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
                headlineLarge: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
                headlineMedium: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.8,
                ),
                headlineSmall: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.7,
                ),
                titleLarge: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.7,
                ),
                titleMedium: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6,
                ),
                bodyLarge: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.6,
                ),
                bodyMedium: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.6,
                  height: 1.5,
                ),
                bodySmall: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
                labelLarge: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.6,
                ),
                labelMedium: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
                labelSmall: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.4,
                ),
              ).apply(
                decorationColor: Colors.orange,
              ),
            ),
            home: SnappingAbove()
            //showHome ? SnappingAbove() : const OnboardingScreen(),
            );
      },
    );
  }
}
