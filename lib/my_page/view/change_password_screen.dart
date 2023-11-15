import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/input_box.dart';

import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/diary_utils.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signUp';

  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _isChangingPassword = false;
  String? currentPasswordErrorMessage;

  Future<void> _changePassword(BuildContext context) async {
    setState(() {
      _isChangingPassword = true;
      currentPasswordErrorMessage = null;
    });

    final isFormValid = _formKey.currentState!.saveAndValidate();
    if (!isFormValid) {
      setState(() {
        _isChangingPassword = false;
      });

      return;
    }

    try {
      final formData = _formKey.currentState!.value;
      final currentPassword = formData['currentPassword'];
      final confirmNewPassword = formData['confirmNewPassword'];

      final user = FirebaseAuth.instance.currentUser!;
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);
      await FirebaseAuth.instance.currentUser!
          .updatePassword(confirmNewPassword);

      if (context.mounted) {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        Navigator.pop(context);
        showCustomToast(context, '비밀번호가 변경되었습니다');
      }
    } catch (e) {
      print("Error: $e");
      String errorMessage = '';
      if (e is FirebaseAuthException) {
        if (e.code == 'wrong-password') {
          errorMessage = '현재 비밀번호가 일치하지 않습니다';
        } else if (e.code == 'too-many-requests') {
          errorMessage = '너무 많은 요청으로 차단되었습니다. 잠시 후 다시 시도해주세요.';
        } else {
          errorMessage = '오류가 발생했습니다. 다시 시도해주세요.';
        }
      } else {
        errorMessage = '오류가 발생했습니다. 다시 시도해주세요.';
      }

      setState(() {
        currentPasswordErrorMessage = errorMessage;
      });
    } finally {
      setState(() {
        _isChangingPassword = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(currentPasswordErrorMessage);
    return DefaultLayout(
      title: "비밀번호 변경",
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: _isChangingPassword
              ? null
              : () {
                  setState(() {
                    currentPasswordErrorMessage = null;
                  });
                  _changePassword(context);
                },
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(0),
            minimumSize: MaterialStateProperty.all(Size(312.w, 42.h)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(pointColor2),
          ),
          child: Text(
            '변경하기',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputBox(
                      name: 'currentPassword',
                      title: '현재 비밀번호',
                      hintText: '현재 비밀번호를 입력해주세요',
                      isPassword: true,
                      currentErrorMessage: currentPasswordErrorMessage,
                      validator: (val) {
                        if (val == null) {
                          return '현재 비밀번호를 입력해주세요';
                        } else if (currentPasswordErrorMessage != null) {
                          return currentPasswordErrorMessage;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0.h),
                    InputBox(
                      name: 'newPassword',
                      title: '새 비밀번호',
                      hintText: '새 비밀번호를 입력해주세요',
                      isPassword: true,
                      condition: '8자 이상 (영문,숫자,기호 중 2종류 조합)',
                      validator: (val) {
                        if (val == null || val.length < 8) {
                          return '비밀번호는 8자 이상이어야 합니다';
                        }
                        // 영문, 숫자, 특수문자 중 2가지 이상 조합을 검사하는 정규식
                        RegExp passwordRegex = RegExp(
                            r'^(?=.*[A-Za-z])(?=.*\d|[\W_])([A-Za-z\d\W_]){8,}$');
                        if (!passwordRegex.hasMatch(val)) {
                          return '형식을 올바르게 입력해주세요';
                        }
                        if (val ==
                            _formKey.currentState!.fields['currentPassword']
                                ?.value) {
                          return '기존 비밀번호와 같습니다';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20.0),
                    InputBox(
                      name: 'confirmNewPassword',
                      title: '새 비밀번호 확인',
                      hintText: '새 비밀번호를 다시 입력해주세요',
                      isPassword: true,
                      validator: (val) {
                        if (val == null ||
                            val !=
                                _formKey.currentState!.fields['newPassword']
                                    ?.value) {
                          return '입력하신 비밀번호와 일치하지 않습니다';
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
      ),
    );
  }
}
