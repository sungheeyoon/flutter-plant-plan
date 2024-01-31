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
  final String? currentErrorMessage;

  const InputBox({
    Key? key,
    required this.name,
    required this.title,
    required this.hintText,
    this.condition,
    this.validator,
    this.isPassword = false,
    this.currentErrorMessage,
  }) : super(key: key);

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool _obscureText = true; // Added to manage obscure text
  String? currentErrorMessage;
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
                obscureText: widget.isPassword ? _obscureText : false,
                name: widget.name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black,
                    ),
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: grayColor400,
                      ),
                  errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: errorColor,
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
                validator: (val) {
                  if (widget.validator != null) {
                    final customError = widget.validator!(val);
                    if (customError != null) {
                      setState(() {
                        currentErrorMessage = customError;
                      });
                      return customError;
                    } else if (widget.currentErrorMessage != null) {
                      setState(() {
                        currentErrorMessage = widget.currentErrorMessage;
                      });
                      return widget.currentErrorMessage;
                    }
                  }
                  setState(() {
                    currentErrorMessage = null;
                  });
                  return null;
                },
              ),
              if (widget.isPassword)
                IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: grayColor600,
                    semanticLabel: 'visibility',
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
