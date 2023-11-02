import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TipButtonWidget extends StatefulWidget {
  final String text;
  final bool isFocused;
  final VoidCallback onPressed;

  const TipButtonWidget({
    super.key,
    required this.text,
    required this.isFocused,
    required this.onPressed,
  });

  @override
  State<TipButtonWidget> createState() => _TipButtonWidgetState();
}

class _TipButtonWidgetState extends State<TipButtonWidget> {
  @override
  Widget build(BuildContext context) {
    const pointColor2 = Colors.blue; // Replace this with your desired color

    return Padding(
      padding: EdgeInsets.only(right: 8.h),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: widget.isFocused ? Colors.white : pointColor2,
          backgroundColor: widget.isFocused ? pointColor2 : Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 8.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.h),
            side: BorderSide(
              width: 1,
              color: widget.isFocused ? Colors.white : pointColor2,
            ),
          ),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
