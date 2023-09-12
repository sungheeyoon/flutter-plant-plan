import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class WithdrawFirstScreen extends StatefulWidget {
  const WithdrawFirstScreen({super.key});

  @override
  State<WithdrawFirstScreen> createState() => _WithdrawFirstScreenState();
}

class _WithdrawFirstScreenState extends State<WithdrawFirstScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> messageList = [
      '사용을 많이 안해요',
      '탈퇴하고 재가입 하고 싶어요',
      '사용하기 어려워요',
      '개인정보를 보호하고 싶어요',
      '기타'
    ];
    TextEditingController messageController = TextEditingController();
    return DefaultLayout(
      title: '회원 탈퇴',
      floatingActionButton: const MyFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              '잠깐만요!',
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              '정말 식플과의 여정을 끝내시겠어요?..',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '식플에서 탈퇴하게 되면 계정을 다시 살리거나 내 식물과 관련된 모든 데이터를 복구 할 수 없습니다 ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayColor600),
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              '케일리님, 탈퇴하시려는 이유가 무엇인가요?',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: grayBlack),
            ),
            const SizedBox(
              height: 12,
            ),
            CustomDropdown(
              hintText: '탈퇴 이유를 선택해주세요',
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayColor400),
              selectedStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
              listItemStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: grayBlack),
              borderSide: const BorderSide(
                color: grayColor400,
                width: 1.0,
              ),
              items: messageList,
              controller: messageController,
            ),
          ],
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
      alignment: Alignment.bottomCenter,
      width: 312.h,
      child: FloatingActionButton(
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) => YourScreen()));
        },
        backgroundColor: Colors.blue,
        child: Text(
          "다음",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
