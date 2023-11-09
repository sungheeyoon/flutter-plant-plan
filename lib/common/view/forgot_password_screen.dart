import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/widget/input_box.dart';
import 'package:plant_plan/utils/colors.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signUp';

  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  String _errorText = '';
  bool _isSendingEmail = false;

  Future<void> emailing(BuildContext context) async {
    print(_errorText);
    setState(() {
      _isSendingEmail = true;
      _errorText = '';
    });
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;
      String email = formData['email'];

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen(),
            ),
            (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _errorText = '존재하지 않는 이메일주소 입니다';
            _isSendingEmail = false;
          });
        } else {
          setState(() {
            _errorText = 'An unexpected error occurred.';
            _isSendingEmail = false;
          });
        }
      } catch (e) {
        setState(() {
          _errorText = '비밀번호 재설정 이메일 전송을 실패했습니다';
          _isSendingEmail = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_isSendingEmail);
    return DefaultLayout(
      title: "비밀번호 찾기",
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            if (_isSendingEmail) {
              return;
            } else {
              emailing(context);
            }
            print(_errorText);
          },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            minimumSize:
                MaterialStateProperty.all(Size(312.w, 42.h)), // 최대 너비 설정
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(pointColor2),
          ),
          child: Text(
            '전송',
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
              child: InputBox(
                name: 'email',
                title: '이메일',
                hintText: '이메일을 입력해주세요',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return '이메일을 입력해주세요.';
                  } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)) {
                    return '이메일 형식이 유효하지 않습니다.';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 8.0.h),
            Text(
              _errorText,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.red,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
