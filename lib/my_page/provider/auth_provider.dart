// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:plant_plan/common/view/home_screen.dart';
// import 'package:plant_plan/common/view/root_tab.dart';
// import 'package:plant_plan/my_page/model/user_model.dart';
// import 'package:plant_plan/my_page/provider/user_me_provider.dart';

// final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
//   return AuthProvider(ref: ref);
// });

// class AuthProvider extends ChangeNotifier {
//   final Ref ref;
//   AuthProvider({
//     required this.ref,
//   }) {
//     ref.listen<UserModelBase>(userMeProvider, (previous, next) {
//       if (previous != next) {
//         notifyListeners();
//       }
//     });
//   }

//   List<GoRoute> get routes => [
//         GoRoute(
//             path: '/',
//             name: RootTab.routeName,
//             builder: (_, __) => const RootTab(),
//            ),
//         GoRoute(
//           path: '/home',
//           name: HomeScreen.routeName,
//           builder: (_, state) => const HomeScreen(),
//         ),
//         GoRoute(
//           path: '/order_done',
//           name: OrderDoneScreen.routeName,
//           builder: (_, state) => const OrderDoneScreen(),
//         ),
//         GoRoute(
//           path: '/splash',
//           name: SplashScreen.routeName,
//           builder: (_, __) => const SplashScreen(),
//         ),
//         GoRoute(
//           path: '/login',
//           name: LoginScreen.routeName,
//           builder: (_, __) => const LoginScreen(),
//         ),
//       ];

//   void logout() {
//     ref.read(userMeProvider.notifier).logout();
//   }

//   // SplashScreen
//   // 앱을 처음 시작했을때
//   // 토큰 ? 홈스크린 : 로그인스크린
//   FutureOr<String?> redirectLogic(GoRouterState state) {
//     final UserModelBase? user = ref.read(userMeProvider);

//     final logginIn = state.location == '/login';

//     // 유저 정보가 없는데
//     // 로그인중이면 그대로 로그인 페이지에 두고
//     // 만약에 로그인중이 아니라면 로그인 페이지로 이동
//     if (user == null) {
//       return logginIn ? null : '/login';
//     }

//     // user가 null이 아님

//     // UserModel
//     // 사용자 정보가 있는 상태면
//     // 로그인 중이거나 현재 위치가 SplashScreen이면
//     // 홈으로 이동
//     if (user is UserModel) {
//       return logginIn || state.location == '/splash' ? '/' : null;
//     }

//     // UserModelError
//     if (user is UserModelError) {
//       return !logginIn ? '/login' : null;
//     }

//     return null;
//   }
// }