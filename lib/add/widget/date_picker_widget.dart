import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';
import 'package:plant_plan/common/utils/date_formatter.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class DatePickerWidget extends ConsumerWidget {
  final PlantField field;
  final String hintText;
  final String? labelText;
  final bool alarm;

  const DatePickerWidget({
    super.key,
    required this.field,
    required this.hintText,
    this.alarm = false,
    this.labelText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plantState = ref.watch(plantInformationProvider);
    final alarmState = ref.watch(alarmProvider);
    final DateTime? date;

    switch (field) {
      case PlantField.watering:
        date = alarm ? alarmState.startTime : plantState.watering.lastDay;
        break;
      case PlantField.repotting:
        date = alarm ? alarmState.startTime : plantState.repotting.lastDay;

        break;
      case PlantField.nutrient:
        date = alarm ? alarmState.startTime : plantState.nutrient.lastDay;
        break;
    }

    return GestureDetector(
      onTap: () async {
        await _showDatePicker(field, ref);
      },
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: TextField(
              enabled: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16),
                hintText: date == null ? hintText : dateFormatter(date),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: date == null ? grayColor400 : grayBlack,
                    ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: keyColor500,
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                  borderSide: BorderSide(
                    width: 1,
                    color: grayColor400,
                  ),
                ),
                disabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                  borderSide: BorderSide(width: 1, color: grayColor400),
                ),
              ),
              keyboardType: TextInputType.name,
            ),
          ),
          if (labelText != null)
            Positioned(
              left: 12,
              top: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: Text(
                    labelText!,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: grayColor600,
                        ),
                  ),
                ),
              ),
            ),
          Positioned(
            right: 10,
            bottom: 13,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: ImageBox(
                  imageUri: 'assets/icons/calendar_box.png',
                  width: 20.h,
                  height: 20.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(PlantField field, WidgetRef ref) async {
    List<DateTime?> singleDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
    final values = await showCalendarDatePicker2Dialog(
      context: ref.context,
      config: CalendarDatePicker2WithActionButtonsConfig(
        firstDate: alarm ? DateTime.now() : DateTime(1),
      ),
      dialogSize: const Size(325, 400),
      value: singleDatePickerValueWithDefaultValue,
      borderRadius: BorderRadius.circular(15),
    );
    if (values != null) {
      if (alarm) {
        ref
            .read(alarmProvider.notifier)
            .setStartTime(StartTimeOption.day, values[0]!);
        // ref
        //     .read(alarmProvider.notifier)
        //     .updateNextAlarmTime(days: alarmState.repeat);
      } else {
        ref
            .read(plantInformationProvider.notifier)
            .updatePlantField(field, lastDay: values[0]!);
      }
    }
  }
}
