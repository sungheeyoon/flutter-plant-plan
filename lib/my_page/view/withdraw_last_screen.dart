import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class WithdrawLastScreen extends StatelessWidget {
  const WithdrawLastScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              return AlertDialog(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                contentPadding: const EdgeInsets.all(0),
                content: SizedBox(
                  width: 312.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 43),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            '해당 다이어리를 삭제하시겠습니까?',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: grayBlack,
                                ),
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
                                  //회원삭제 추가예정
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  '삭제하기',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: errorColor,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  '취소',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
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
            Text(
              '\u{1F4CD} 계정이 삭제된 이후에는 계정을 다시 살리거나 식물, 알림  및 다이어리 등의 데이터를 복구할 수 없어요',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
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
