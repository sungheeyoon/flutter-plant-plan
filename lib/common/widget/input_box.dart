import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class InputBox extends StatefulWidget {
  final String name;
  final String title;
  final String hintText;
  final String? Function(String?)? validator;
  final String? condition;
  final bool isPassword;

  const InputBox({
    Key? key,
    required this.name,
    required this.title,
    required this.hintText,
    this.condition,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscureText = true; // Added to manage obscure text

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
        Row(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: primaryColor,
                  ),
            ),
            const SizedBox(
              width: 6,
            ),
            if (widget.condition is String)
              Text(
                widget.condition!,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: grayColor500,
                    ),
              ),
          ],
        ),
        SizedBox(
          height: 4.h,
        ),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              FormBuilderTextField(
                focusNode: _focusNode,
                obscureText: _obscureText,
                name: widget.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grayColor400,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: grayColor400,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: keyColor500,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: errorColor,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                ),
                validator: widget.validator,
              ),
              if (widget
                  .isPassword) // Toggle visibility icon for password field
                IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: grayColor600,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
