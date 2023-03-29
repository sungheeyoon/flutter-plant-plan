import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/user/repository/auth_repository.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/snapping_above.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "내 식물을 위한 플랜",
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: primaryColor,
                  ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              "식플 ",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w700,
                color: primaryColor,
                height: 0,
              ),
            ),
            SizedBox(
              height: 66.h,
            ),
            const Image(
              image: AssetImage('assets/images/login/login.png'),
              width: 72,
              height: 90,
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 80.h,
            ),
            Text(
              '3초만에 로그인하고 이용하기',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grayColor700,
                  ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () async {
                    final isLogin = await ref.read(kakaoLoginProvider).login();
                    if (isLogin) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => SnappingAbove(),
                        ),
                      );
                    }
                  },
                  child: const Image(
                    image: AssetImage('assets/images/login/kakao.png'),
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                const Image(
                  image: AssetImage('assets/images/login/naver.png'),
                  width: 56,
                  height: 56,
                  fit: BoxFit.contain,
                ),
                const SizedBox(
                  width: 16.0,
                ),
                const Image(
                  image: AssetImage('assets/images/login/google.png'),
                  width: 58,
                  height: 58,
                  fit: BoxFit.contain,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
