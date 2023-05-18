import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/input_box.dart';
import 'package:plant_plan/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _loginKey = GlobalKey<FormBuilderState>();
  String _errorText = '';

  Future<void> _login(BuildContext context) async {
    if (_loginKey.currentState!.saveAndValidate()) {
      final formData = _loginKey.currentState!.value;
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: formData['email'],
          password: formData['password'],
        );
        // 로그인 성공
        // 추가적인 작업 수행 또는 홈 화면으로 이동
        print('로그인 성공: ${userCredential.user!.uid}');
      } on FirebaseAuthException catch (e) {
        // 로그인 실패
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          setState(() {
            _errorText = '이메일혹은 비밀번호가 잘못되었습니다.';
          });
          print('로그인 실패: ${e.code}');
        } else {
          setState(() {
            _errorText = '이메일혹은 비밀번호가 잘못되었습니다.';
          });
          print('로그인 실패: ${e.message}');
        }
      }
    } else {
      print('로그인 실패: 유효성 검사 실패');
    }
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
                    InputBox(
                      name: 'email',
                      title: '이메일',
                      hintText: '이메일을 입력해주세요',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '이메일을 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12.0.h),
                    InputBox(
                      name: 'password',
                      title: '비밀번호',
                      hintText: '비밀번호를 입력해주세요',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return '비밀번호를 입력해주세요.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
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
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 42)), // 최대 너비 설정
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/images/login/kakao.png'),
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Image(
                    image: AssetImage('assets/images/login/naver.png'),
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                  Image(
                    image: AssetImage('assets/images/login/google.png'),
                    width: 58,
                    height: 58,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(
                height: 80.h,
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
                      // 회원가입 버튼을 눌렀을 때 수행할 동작
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
