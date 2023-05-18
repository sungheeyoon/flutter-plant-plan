import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class InputBox extends StatelessWidget {
  final String name;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  const InputBox({
    super.key,
    required this.name,
    required this.title,
    required this.hintText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: grayColor600,
              ),
        ),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
          width: double.infinity,
          child: FormBuilderTextField(
            name: name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: grayBlack,
                ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: grayColor400,
                  ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: grayColor400, // 비활성화 상태에서의 외곽선 색상 설정
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: keyColor500, // 활성화 상태에서의 외곽선 색상 설정
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red, // 실패 상태에서의 외곽선 색상 설정
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: Colors.red, // 실패 상태에서의 외곽선 색상 설정
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10, // 위아래 패딩
                horizontal: 16, // 좌우 패딩
              ),
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
