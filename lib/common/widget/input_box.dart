import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class InputBox extends StatefulWidget {
  final String name;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final bool isPassword;

  const InputBox({
    Key? key,
    required this.name,
    required this.title,
    required this.hintText,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: grayColor600, // Changed to grey for consistency
              ),
        ),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
          width: double.infinity,
          child: FormBuilderTextField(
            focusNode: _focusNode,
            obscureText: widget.isPassword,
            name: widget.name,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.black, // Changed to black for consistency
                ),
            decoration: InputDecoration(
              hintText: widget.hintText,
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
                  color: errorColor, // 실패 상태에서의 외곽선 색상 설정
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: errorColor, // 실패 상태에서의 외곽선 색상 설정
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
            ),
            validator: widget.validator,
          ),
        ),
      ],
    );
  }
}
