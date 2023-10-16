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
  State createState() => _SearchWidgetState();
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

    return SizedBox(
      width: 312.w,
      height: 42.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: grayColor100,
            suffixIcon: widget.text.isNotEmpty
                ? GestureDetector(
                    child: const Icon(Icons.close, color: grayColor600),
                    onTap: () {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                  )
                : const Icon(Icons.search, color: grayColor600),
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
