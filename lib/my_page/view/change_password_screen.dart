import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/input_box.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/utils/colors.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  static String get routeName => 'signUp';

  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String? _emailErrorMessage;

  Future<void> _changePassword(BuildContext context) async {
    if (_formKey.currentState!.saveAndValidate()) {
      final formData = _formKey.currentState!.value;

      final String currentPassword = formData['currentPassword'];

      final String confirmNewPassword = formData['confirmNewPassword'];

      final UserModel user = ref.read(userMeProvider) as UserModel;

      final bool checkCurrentPassword = await ref
          .read(userMeProvider.notifier)
          .checkPassword(id: user.id, password: currentPassword);
      if (checkCurrentPassword) {
        await ref
            .read(userMeProvider.notifier)
            .updatePassword(confirmNewPassword);
        if (context.mounted) Navigator.pop(context);
      } else {
        setState(() {
          _emailErrorMessage = '비밀번호가 틀렸습니다.';
        });
      }
    }
  }

  Future<void> checkCurrentPassword(String password) async {
    final UserModel user = ref.read(userMeProvider) as UserModel;
    ref
        .read(userMeProvider.notifier)
        .checkPassword(id: user.id, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "비밀번호 변경",
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ElevatedButton(
          onPressed: () => _changePassword(context),
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
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return '현재 비밀번호를 입력해주세요.';
                      } else if (_emailErrorMessage != null) {
                        return _emailErrorMessage;
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0.h),
                  InputBox(
                    name: 'newPassword',
                    title: '새 비밀번호',
                    hintText: '새 비밀번호를 입력해주세요',
                    condition: '8자 이상 (영문,숫자,기호 중 2종류 조합)',
                    validator: (val) {
                      if (val == null || val.length < 8) {
                        return '비밀번호는 8자 이상이어야 합니다.';
                      }
                      // 영문, 숫자, 특수문자 중 2가지 이상 조합을 검사하는 정규식
                      RegExp passwordRegex = RegExp(
                          r'^(?=.*[A-Za-z])(?=.*\d|[\W_])([A-Za-z\d\W_]){8,}$');
                      if (!passwordRegex.hasMatch(val)) {
                        return '비밀번호는 영문, 숫자, 기호 중 2가지 이상 조합이어야 합니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  InputBox(
                    name: 'confirmNewPassword',
                    title: '새 비밀번호 확인',
                    hintText: '새 비밀번호를 다시 입력해주세요',
                    validator: (val) {
                      if (val == null ||
                          val !=
                              _formKey
                                  .currentState!.fields['newPassword']?.value) {
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
    );
  }
}
