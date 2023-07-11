import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';

enum StartTimeOption { day, time }

final alarmProvider = StateNotifierProvider<AlarmNotifier, Alarm>((ref) {
  return AlarmNotifier();
});

class AlarmNotifier extends StateNotifier<Alarm> {
  AlarmNotifier()
      : super(
          Alarm.newAlarm(startTime: DateTime.now(), field: PlantField.none),
        );

  void setStartTime(
    StartTimeOption dayOrTime,
    DateTime time,
  ) {
    //setStartTime 으로 인해 추가된다면 isOn 을 true로바꾼다.
    DateTime result = DateTime.now();
    if (dayOrTime == StartTimeOption.day) {
      result = DateTime(
        time.year,
        time.month,
        time.day,
        state.startTime.hour,
        state.startTime.minute,
        state.startTime.second,
      );
    }
    if (dayOrTime == StartTimeOption.time) {
      result = DateTime(
        state.startTime.year,
        state.startTime.month,
        state.startTime.day,
        time.hour,
        time.minute,
        time.second,
      );
    }

    state = state.copyWith(startTime: result, isOn: true);
  }

  void setDateTimeNull() {
    state = state.copyWith(startTime: DateTime.now());
  }

  void setRepeat(int repeat) {
    state = state.copyWith(repeat: repeat);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setFieldAndReset(PlantField field) {
    state = Alarm.newAlarm(startTime: DateTime.now(), field: field);
  }

  void setAlarm(Alarm? alarm) {
    if (alarm == null) {
      reset();
    } else {
      state = alarm;
    }
  }

  void reset() {
    state = Alarm.newAlarm(startTime: DateTime.now(), field: PlantField.none);
  }
}
