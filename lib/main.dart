import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/view/onboarding_screen.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/services/login_manager.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:timezone/data/latest.dart' as tz;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await Firebase.initializeApp();

  final autoLoginManager = LoginManager();
  await autoLoginManager.initialize();

  final isShowLogin = autoLoginManager.isShowLogin;
  final isAutoLogin = autoLoginManager.isAutoLogin;

  runApp(
    // 프로덕션용
    ProviderScope(
      child: MyApp(isShowLogin: isShowLogin, isAutoLogin: isAutoLogin),
    ),
    // 해상도 대응용
    // ProviderScope(
    //   child: DevicePreview(
    //     builder: (context) =>
    //         MyApp(isShowLogin: isShowLogin, isAutoLogin: isAutoLogin),
    //   ),
    // ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  final bool isShowLogin;
  final bool isAutoLogin;

  const MyApp({
    Key? key,
    required this.isShowLogin,
    required this.isAutoLogin,
  }) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  String determineInitialRoute(
      bool isShowLogin, bool isAutoLogin, UserModelBase userState) {
    // 첫 실행  isShowLogin 이 false인 경우 OnboardingScreen으로 이동
    if (isShowLogin == false) {
      return '/onboarding';
    }

    // 자동 로그인 및 사용자 상태에 따라 경로 결정
    if (userState is UserModel) {
      if (!isAutoLogin) {
        // 로그아웃 및 로그인 화면으로 이동
        // ref.read(userMeProvider.notifier).logout();
        return '/login';
      } else {
        return '/rootTab';
      }
    } else {
      return '/login';
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModelBase userState = ref.watch(userMeProvider);

    String initialRoute = determineInitialRoute(
        widget.isShowLogin, widget.isAutoLogin, userState);
    return ScreenUtilInit(
      designSize: const Size(360, 760),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.light,
            ).copyWith(
              surface: Colors.white,
            ),
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
                fontSize: 14.0.sp,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.6.sp,
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
            ),
          ),
          initialRoute: initialRoute,
          routes: {
            '/login': (context) => const LoginScreen(),
            '/onboarding': (context) => const OnboardingScreen(),
            '/rootTab': (context) => const RootTab(),
          },
        );
      },
    );
  }
}
