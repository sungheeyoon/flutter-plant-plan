import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final String name;
  final double width;
  final double height;

  const RoundedButton({
    super.key,
    required this.backgroundColor,
    required this.borderColor,
    required this.width,
    required this.height,
    required this.textColor,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: () async {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
          backgroundColor: backgroundColor,
        ),
        child: Text(
          name,
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color: textColor,
              ),
        ),
      ),
    );
  }
}
