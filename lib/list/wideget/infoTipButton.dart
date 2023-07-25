import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailTipButton extends StatefulWidget {
  final String text;
  final bool isFocused;
  final VoidCallback onPressed;

  const DetailTipButton({
    Key? key,
    required this.text,
    required this.isFocused,
    required this.onPressed,
  }) : super(key: key);

  @override
  _DetailTipButtonState createState() => _DetailTipButtonState();
}

class _DetailTipButtonState extends State<DetailTipButton> {
  @override
  Widget build(BuildContext context) {
    const pointColor2 = Colors.blue; // Replace this with your desired color

    return ElevatedButton(
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
    );
  }
}
