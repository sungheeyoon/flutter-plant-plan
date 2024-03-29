import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:plant_plan/add/provider/alarm_provider.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';

class DatePickerWidget extends ConsumerWidget {
  final PlantField field;
  final String hintText;
  final String? labelText;

  const DatePickerWidget({
    super.key,
    required this.field,
    required this.hintText,
    this.labelText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alarmState = ref.watch(alarmProvider);
    final date = alarmState.startTime;

    return GestureDetector(
      onTap: () => _showDatePicker(field, ref),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: TextField(
              enabled: false,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 16),
                hintText: dateFormatter(date),
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: grayBlack,
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
            bottom: 21,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: Image(
                  image: const AssetImage('assets/icons/calendar_box.png'),
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
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        selectedDayHighlightColor: pointColor2,
      ),
      dialogSize: const Size(325, 400),
      value: singleDatePickerValueWithDefaultValue,
      borderRadius: BorderRadius.circular(15),
      dialogBackgroundColor: Colors.white,
    );
    if (values != null) {
      ref
          .read(alarmProvider.notifier)
          .setStartTime(StartTimeOption.day, values[0]!);
    }
  }
}
