import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:plant_plan/add/model/info_input_model.dart';
import 'package:plant_plan/add/provider/info_input_provider.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/image_box.dart';

class DatePickerWidget extends ConsumerWidget {
  final InfoKey infoKey;
  final String hintText;
  final String? labelText;

  const DatePickerWidget({
    super.key,
    required this.infoKey,
    required this.hintText,
    this.labelText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedInfo = ref.watch(infoInputProvider);
    String info = "";
    switch (infoKey) {
      case InfoKey.alias:
        break;
      case InfoKey.wateringDay:
        info = selectedInfo.wateringDay;
        break;
      case InfoKey.repottingDay:
        info = selectedInfo.repottingDay;
        break;
      case InfoKey.nutrientDay:
        info = selectedInfo.nutrientDay;
        break;
      default:
        info = "Error";
    }
    return GestureDetector(
      onTap: () async {
        await _showDatePicker(infoKey, ref);
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
                hintText: info == "" ? hintText : info,
                hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: info == "" ? grayColor400 : grayBlack,
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

  Future<void> _showDatePicker(InfoKey infoKey, WidgetRef ref) async {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    List<DateTime?> singleDatePickerValueWithDefaultValue = [
      DateTime.now(),
    ];
    final values = await showCalendarDatePicker2Dialog(
      context: ref.context,
      config: CalendarDatePicker2WithActionButtonsConfig(),
      dialogSize: const Size(325, 400),
      value: singleDatePickerValueWithDefaultValue,
      borderRadius: BorderRadius.circular(15),
    );
    if (values != null) {
      String value = formatter.format(values[0]!);
      ref
          .read(infoInputProvider.notifier)
          .setInfoInput(key: infoKey, value: value);
    }
  }
}
