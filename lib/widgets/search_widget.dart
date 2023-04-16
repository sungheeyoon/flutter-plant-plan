import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/utils/colors.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle styleActive =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayBlack);
    TextStyle styleHint =
        Theme.of(context).textTheme.bodyMedium!.copyWith(color: grayColor500);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42.h,
      width: 360.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: grayColor100,
        border: Border.all(color: grayColor100),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(20, 3, 1, 0),
                      child: Icon(Icons.close, color: grayColor600),
                    ),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : const Padding(
                    padding: EdgeInsets.fromLTRB(20, 3, 1, 0),
                    child: Icon(Icons.search, color: grayColor600),
                  ),
            hintText: widget.hintText,
            hintStyle: style,
            border: InputBorder.none,
          ),
          style: style,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
