import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/root_tab.dart';
import 'package:plant_plan/common/widget/input_box.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/utils/colors.dart';

class SignUpForm extends ConsumerStatefulWidget {
  static String get routeName => 'signUp';

  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String? _emailErrorMessage;

  Future<void> _signUp(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      final email = formData['email'];

      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: formData['password'],
        );

        if (userCredential.user != null) {
          // 회원가입 성공
          await userCredential.user?.updateDisplayName(formData['name']);
          //user 정보 데이터베이스에 등록
          await FirebaseFirestore.instance
              .collection('user')
              .doc(userCredential.user!.uid)
              .set({
            'userName': formData['name'],
            'email': email,
          });
          print('회원가입 성공');
          try {
            await performLogin(formData['email'], formData['password']);
          } catch (e) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ErrorScreen(errorMessage: e.toString())),
            );
          }
        } else {
          print('회원가입 실패');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          setState(() {
            _emailErrorMessage = '이미 가입된 이메일 주소입니다.';
          });
        } else {
          print('회원가입 에러: $e');
        }
      } catch (e) {
        print('회원가입 에러: $e');
      }
    }
  }

  Future<void> performLogin(
    String email,
    String password,
  ) async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Login success
    if (context.mounted) {
      // Modify the user state after successful login
      ref.read(userMeProvider.notifier).login(email: email, password: password);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => const RootTab()),
        (route) => false,
      );
    }
    print('로그인 성공: ${userCredential.user!.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "회원가입",
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () => _signUp(context),
          style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.all(Size(312.h, 42.h)), // 최대 너비 설정
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(pointColor2),
          ),
          child: Text(
            '회원가입하기',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputBox(
                    name: 'name',
                    title: '닉네임',
                    hintText: '이름을 입력해주세요',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '이름을 입력해주세요.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0.h),
                  InputBox(
                    name: 'email',
                    title: '이메일',
                    hintText: '이메일을 입력해주세요',
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '이메일을 입력해주세요.';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val)) {
                        return '이메일 형식이 유효하지 않습니다.';
                      } else if (_emailErrorMessage != null) {
                        return _emailErrorMessage;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0.h),
                  InputBox(
                    name: 'password',
                    title: '비밀번호',
                    hintText: '비밀번호를 입력해주세요',
                    validator: (val) {
                      if (val == null || val.length < 6) {
                        return '비밀번호는 6자 이상이어야 합니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  InputBox(
                    name: 'confirmPassword',
                    title: '비밀번호 확인',
                    hintText: '비밀번호를 다시 입력해주세요',
                    validator: (val) {
                      if (val == null ||
                          val !=
                              _formKey
                                  .currentState!.fields['password']?.value) {
                        return '비밀번호가 일치하지 않습니다.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
