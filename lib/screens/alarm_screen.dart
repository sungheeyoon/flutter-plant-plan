import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '알람설정', home: false),
      body: Container(
        color: gray5Color,
        child: Column(children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          hourMinute12H()
        ]),
      ),
    );
  }

  Widget hourMinute12H() {
    return TimePickerSpinner(
      is24HourMode: false,
      normalTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 32,
          color: primary3Color.withOpacity(0.2)),
      highlightedTextStyle: const TextStyle(
          fontWeight: FontWeight.w400, fontSize: 32, color: primary3Color),
      alignment: Alignment.center,
      onTimeChange: (time) {
        setState(() {
          _dateTime = time;
        });
      },
    );
  }
}
