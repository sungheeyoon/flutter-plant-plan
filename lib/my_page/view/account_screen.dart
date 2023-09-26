import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/view/error_screen.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/widget/delete_modal.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/my_page/view/withdraw_first_screen.dart';
import 'package:plant_plan/services/login_manager.dart';
import 'package:plant_plan/utils/colors.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final userMeState = ref.watch(userMeProvider);
    if (userMeState is UserNotLoggedIn) {
      // Navigate to login screen if not logged in
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });
      return Container();
    } else if (userMeState is UserModelError) {
      return ErrorScreen(errorMessage: userMeState.message);
    } else if (userMeState is UserModel) {
      return DefaultLayout(
        title: '계정정보',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AccountInfo(userMeState: userMeState),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '로그인',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: grayBlack,
                        ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Divider(
                    thickness: 1,
                    color: grayBlack,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '로그인 방식',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        Text(
                          '이메일',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayBlack,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: grayColor300,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '자동로그인',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: grayColor600,
                                  ),
                        ),
                        CupertinoSwitch(
                          value: LoginManager().isAutoLogin,
                          onChanged: (value) {
                            setState(() {
                              LoginManager().setAutoLogin(value);
                            });
                          },
                          trackColor: grayColor400,
                          activeColor: pointColor2,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: grayColor300,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return DeleteModal(
                            text: '정말 로그아웃 하시겠습니까?',
                            buttonText: '로그아웃',
                            isRed: false,
                            onPressed: () {
                              ref.read(userMeProvider.notifier).logout();

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                              Navigator.of(context).pop();
                            },
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 136, // Fills the available width
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 0), // Adjust padding here
                      child: Text(
                        '로그아웃',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: grayColor300,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WithdrawFirstScreen(),
                      ),
                    ),
                    child: Container(
                      width: 136, // Fills the available width
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 0), // Adjust padding here
                      child: Text(
                        '탈퇴하기',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: grayColor600,
                            ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    super.key,
    required this.userMeState,
  });

  final UserModel userMeState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 12,
        ),
        Text(
          '회원 정보',
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: grayBlack,
              ),
        ),
        const SizedBox(
          height: 4,
        ),
        const Divider(
          thickness: 1,
          color: grayBlack,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '닉네임',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayColor600,
                    ),
              ),
              Text(
                userMeState.username,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayBlack,
                    ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: grayColor300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '이메일',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayColor600,
                    ),
              ),
              Text(
                userMeState.id,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayBlack,
                    ),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: grayColor300,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 18),
          child: Text(
            '비밀번호 변경',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: grayColor600,
                ),
          ),
        ),
      ],
    );
  }
}
