import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String name;
  final double width;
  final double height;
  final TextStyle? font;
  final VoidCallback? onPressed;

  const RoundedButton({
    super.key,
    required this.font,
    required this.backgroundColor,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.textColor,
    required this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          name,
          style: font!.copyWith(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
