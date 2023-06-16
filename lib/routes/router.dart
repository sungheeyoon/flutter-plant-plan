import 'package:go_router/go_router.dart';
import 'package:plant_plan/add/view/add_first_screen.dart';
import 'package:plant_plan/add/view/add_second_screen.dart';
import 'package:plant_plan/add/view/add_third_screen.dart';
import 'package:plant_plan/add/view/search_screen.dart';
import 'package:plant_plan/common/view/home_screen.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/view/onboarding_screen.dart';
import 'package:plant_plan/common/view/sign_up_form.dart';
import 'package:plant_plan/common/view/splash_screen.dart';

GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          path: 'addFirst',
          name: AddFirstScreen.routeName,
          builder: (context, state) => const AddFirstScreen(),
          routes: [
            GoRoute(
              path: 'search',
              name: SearchScreen.routeName,
              builder: (context, state) => const SearchScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'addSecond',
          name: 'addSecond',
          builder: (context, state) => const AddSecondScreen(),
        ),
        GoRoute(
          path: 'addThird',
          name: 'addThird',
          builder: (context, state) => const AddThirdScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/splash',
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      name: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'signUp',
          name: SignUpForm.routeName,
          builder: (context, state) => SignUpForm(),
        ),
      ],
    ),
    GoRoute(
      path: '/onBording',
      name: OnboardingScreen.routeName,
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);