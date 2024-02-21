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


    return ClipRRect(

      borderRadius: BorderRadius.circular(8.0.w),

      child: TextField(

        textAlignVertical: TextAlignVertical.center,

        controller: controller,

        decoration: InputDecoration(

          contentPadding: EdgeInsets.fromLTRB(16.w, 10.w, 0, 10.w),

          filled: true,

          fillColor: grayColor100,

          suffixIcon: widget.text.isNotEmpty

              ? GestureDetector(

                  child: Icon(

                    Icons.close,

                    color: grayColor600,

                    size: 16.w,

                  ),

                  onTap: () {

                    controller.clear();


                    widget.onChanged('');


                    FocusScope.of(context).requestFocus(FocusNode());

                  },

                )

              : Icon(

                  Icons.search,

                  color: grayColor600,

                  size: 16.w,

                ),

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

