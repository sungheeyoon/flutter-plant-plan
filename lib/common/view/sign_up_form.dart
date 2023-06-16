import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/input_box.dart';

class SignUpForm extends StatelessWidget {
  static String get routeName => 'signUp';
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  SignUpForm({super.key});

  Future<void> _signUp(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      try {
        final userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: formData['email'],
          password: formData['password'],
        );

        if (userCredential.user != null) {
          // 회원가입 성공
          //user 정보 데이터베이스에 등록
          await FirebaseFirestore.instance
              .collection('user')
              .doc(userCredential.user!.uid)
              .set({
            'userName': formData['name'],
            'email': formData['email'],
          });
          print('회원가입 성공');
          // 추가적인 작업 수행 또는 홈 화면으로 이동
        } else {
          // 회원가입 실패
          print('회원가입 실패');
        }
      } catch (e) {
        // 회원가입 에러 처리
        print('회원가입 에러: $e');
      }
    }
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
        child: FormBuilder(
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
                  if (val == null || !val.contains('@')) {
                    return '이메일 형식이 유효하지 않습니다.';
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
                      val != _formKey.currentState!.fields['password']?.value) {
                    return '비밀번호가 일치하지 않습니다.';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}