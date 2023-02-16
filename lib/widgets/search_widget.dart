import 'package:flutter/material.dart';
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
        Theme.of(context).textTheme.titleMedium!.copyWith(color: primary3Color);
    TextStyle styleHint =
        Theme.of(context).textTheme.titleMedium!.copyWith(color: gray2Color);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.fromLTRB(24, 20, 24, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: gray4Color,
        border: Border.all(color: gray4Color),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: const Icon(Icons.search, color: gray1Color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: const Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: Icon(Icons.close, color: gray1Color),
                  ),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
