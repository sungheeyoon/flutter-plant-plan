import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/provider/plants_provider.dart';
import 'package:plant_plan/common/view/login_screen.dart';
import 'package:plant_plan/common/widget/delete_modal.dart';
import 'package:plant_plan/my_page/provider/user_me_provider.dart';
import 'package:plant_plan/utils/colors.dart';

class WithdrawLastScreen extends ConsumerWidget {
  const WithdrawLastScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      title: '회원 탈퇴',
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: 360.w,
        child: FloatingActionButton.extended(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              return DeleteModal(
                text: '정말 계정을 삭제하시겠습니까?',
                buttonText: '삭제하기',
                isRed: true,
                onPressed: () async {
                  ref.read(plantsProvider.notifier).deleteAll();
                  await ref.read(userMeProvider.notifier).withdraw();
                  if (!context.mounted) return;
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                  );
                  Navigator.of(context).pop();
                },
              );
            },
          ),
          label: Text(
            "계정 삭제",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          backgroundColor: errorColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 31,
            ),
            Text(
              '계정을 삭제하게 되면,',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 31,
            ),
            Text(
              '\u{1F4CD} 등록한 식물 및 정보가 모두 삭제돼요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '\u{1F4CD} 설정한  식물 알림이 모두 삭제돼요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '\u{1F4CD} 작성한 다이어리 및 사진이 모두 삭제돼요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('\u{1F4CD}'),
                const SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    '계정이 삭제된 이후에는 계정을 다시 살리거나 식물, 알림  및 다이어리 등의 데이터를 복구할 수 없어요',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayBlack),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2, // 최대 두 줄까지 표시
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '\u{1F4CD} 현재 계정으로는 다시 로그인할 수 없어요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              '\u{1F4CD} 7일 동안 재가입이 불가능해요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: errorColor),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
