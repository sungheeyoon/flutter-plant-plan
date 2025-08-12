import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/my_page/view/withdraw_last_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class WithdrawFirstScreen extends StatefulWidget {
  final String username;
  const WithdrawFirstScreen({
    super.key,
    required this.username,
  });

  @override
  State<WithdrawFirstScreen> createState() => _WithdrawFirstScreenState();
}

class _WithdrawFirstScreenState extends State<WithdrawFirstScreen> {
  SingleSelectController<String?> reasonController = SingleSelectController<String?>(null);
  TextEditingController messageController = TextEditingController();
  @override
  void dispose() {
    reasonController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> reasonList = [
      '사용을 많이 안해요',
      '탈퇴하고 재가입 하고 싶어요',
      '사용하기 어려워요',
      '개인정보를 보호하고 싶어요',
      '기타'
    ];

    return DefaultLayout(
      title: '회원 탈퇴',
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        width: 360.w,
        child: ElevatedButton(
          onPressed: () {
            final reason = reasonController.value;
            if ((reason == null || reason.isEmpty || reason == '기타') &&
                messageController.text.isEmpty) {
              return;
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WithdrawLastScreen()));
            }
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
            minimumSize: const Size(0, 52),
            backgroundColor: () {
              final reason = reasonController.value;
              return (reason == null || reason.isEmpty || reason == '기타') &&
                      messageController.text.isEmpty
                  ? grayColor300
                  : errorColor;
            }(),
          ),
          child: Text(
            "탈퇴하기",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
      ),
      child: SingleChildScrollView(
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
                '${widget.username}님, 탈퇴하시려는 이유가 무엇인가요?',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: grayBlack),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomDropdown<String>(
                hintText: '탈퇴 이유를 선택해주세요',
                items: reasonList,
                controller: reasonController,
                decoration: CustomDropdownDecoration(
                  closedBorderRadius: BorderRadius.circular(8),
                  expandedBorderRadius: BorderRadius.circular(8),
                  closedBorder: const Border.fromBorderSide(BorderSide(
                    color: grayColor400,
                    width: 1.0,
                  )),
                  expandedBorder: const Border.fromBorderSide(BorderSide(
                    color: grayColor400,
                    width: 1.0,
                  )),
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grayColor400),
                  closedFillColor: Colors.white,
                  expandedFillColor: Colors.white,
                ),
                onChanged: (p0) {
                  setState(() {
                    // SingleSelectController는 자동으로 값이 설정되므로 별도 설정 불필요
                  });
                },
              ),
              const SizedBox(
                height: 12,
              ),
              if (reasonController.value == '기타')
                TextFormField(
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: grayBlack),
                  controller: messageController,
                  maxLines: 5,
                  maxLength: 500,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: grayColor400,
                      ),
                    ),
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: grayColor400),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 16.0),
                    hintText: '탈퇴 이유를 입력해주세요',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: grayColor400),
                  ),
                  onChanged: (value) {
                    setState(() {
                      // UI 상태 업데이트
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
