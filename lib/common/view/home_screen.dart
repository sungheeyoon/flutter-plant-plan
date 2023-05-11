import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/home_calendar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        child: SingleChildScrollView(
      child: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 230.h,
            child: const MyCalendar(),
          ),
        ],
      )),
    ));
  }
}
