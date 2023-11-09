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
  String? _errorText;
  bool _isSendingEmail = false;

  Future<void> emailing(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      setState(() {
        _isSendingEmail = true;
      });
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
        _showResetEmailModal(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            _errorText = '존재하지 않는 유저 이메일주소 입니다';
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

  void _showResetEmailModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Modal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "비밀번호 찾기",
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () {
            if (_isSendingEmail) {
              return;
            } else {
              setState(() {
                _errorText = null;
              });
              emailing(context);
            }
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
                currentErrorMessage: _errorText,
                validator: (val) {
                  if (val == null) {
                    return '이메일을 입력해주세요.';
                  } else if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(val)) {
                    return '이메일 형식이 유효하지 않습니다.';
                  } else if (_errorText != null) {
                    return _errorText;
                  }

                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      contentPadding: const EdgeInsets.all(0),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 312.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 43),
              child: Text(
                '가입한 이메일로 전송된 메일을 확인해주세요',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayBlack,
                    ),
              ),
            ),
            const Divider(
              color: grayColor200,
              thickness: 2,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        '확인',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              color: primaryColor,
                            ),
                      ),
                    ),
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
