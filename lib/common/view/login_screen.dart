import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/common/view/sign_up_form.dart';
import 'package:plant_plan/common/widget/input_box.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/utils/colors.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();
  String _errorText = '';

  void _login(BuildContext context) async {
    if (_loginKey.currentState!.saveAndValidate()) {
      final formData = _loginKey.currentState!.value;
      setState(() {
        _errorText = ''; // Reset error message
      });

      if (formData['email'] == null || formData['email'].isEmpty) {
        setState(() {
          _errorText = '이메일을 입력해주세요.';
        });
        return;
      }

      if (formData['password'] == null || formData['password'].isEmpty) {
        setState(() {
          _errorText = '비밀번호를 입력해주세요.';
        });
        return;
      }

      try {
        await performLogin(formData['email'], formData['password']);
      } catch (e) {
        displayError(e);
      }
    } else {
      print('로그인 실패: 유효성 검사 실패');
    }
  }

  Future<void> performLogin(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Login success
      if (context.mounted) {
        // Modify the user state after successful login
        ref
            .read(userMeProvider.notifier)
            .login(email: email, password: password);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => const RootTab()),
          (route) => false,
        );
      }
      print('로그인 성공: ${userCredential.user!.uid}');
    } catch (e) {
      displayError(e);
    }
  }

  void displayError(dynamic error) {
    String errorMessage = '로그인에 실패했습니다.';
    if (error is FirebaseAuthException) {
      if (error.code == 'user-not-found' || error.code == 'wrong-password') {
        errorMessage = '이메일 혹은 비밀번호가 잘못되었습니다.';
      }
    }

    setState(() {
      _errorText = errorMessage;
    });

    print('로그인 실패: $errorMessage');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100.h,
              ),
              Text(
                "내 식물을 위한 플랜",
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: primaryColor,
                    ),
              ),
              SizedBox(
                height: 12.h,
              ),
              const Image(
                image: AssetImage('assets/images/login/logo.png'),
                width: 122,
                height: 46,
                fit: BoxFit.contain,
              ),
              SizedBox(
                height: 80.h,
              ),
              FormBuilder(
                key: _loginKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const InputBox(
                      name: 'email',
                      title: '이메일',
                      hintText: '이메일을 입력해주세요',
                    ),
                    SizedBox(height: 12.0.h),
                    const InputBox(
                      name: 'password',
                      title: '비밀번호',
                      hintText: '비밀번호를 입력해주세요',
                      isPassword: true,
                    ),
                    SizedBox(height: 8.0.h),
                    Text(
                      _errorText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    SizedBox(height: 36.0.h),
                    ElevatedButton(
                      onPressed: () => _login(context),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 42)), // 최대 너비 설정
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(pointColor2),
                      ),
                      child: Text(
                        '로그인',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey, // 변경된 색상
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    '또는 간편로그인하기',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grayColor700,
                        ),
                  ),
                  const SizedBox(width: 8.0),
                  const Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.grey, // 변경된 색상
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/login/kakao.png'),
                    width: 56.h,
                    height: 56.h,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Image(
                    image: const AssetImage('assets/images/login/naver.png'),
                    width: 56.h,
                    height: 56.h,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Image(
                    image: const AssetImage('assets/images/login/google.png'),
                    width: 58.h,
                    height: 58.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(
                height: 60.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '아직 식플의 회원이 아니신가요?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                  SizedBox(width: 8.h),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignUpForm();
                      }));
                    },
                    child: Text(
                      '회원가입',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                            color: pointColor2,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
