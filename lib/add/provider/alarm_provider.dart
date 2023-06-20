import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

enum AlarmDateTimeField {
  startTime,
  startDay,
  nextAlarm,
}

final alarmProvider = StateNotifierProvider<AlarmNotifier, Alarm>((ref) {
  return AlarmNotifier();
});

class AlarmNotifier extends StateNotifier<Alarm> {
  AlarmNotifier()
      : super(
          Alarm(startTime: DateTime.now()),
        );

  void setDateTime(
    AlarmDateTimeField field,
    DateTime time,
  ) {
    state = state.copyWith(
      startTime: field == AlarmDateTimeField.startTime ? time : state.startTime,
      startDay: field == AlarmDateTimeField.startDay ? time : state.startDay,
      nextAlarm: field == AlarmDateTimeField.nextAlarm ? time : state.nextAlarm,
    );
  }

  void setDateTimeNull(
    AlarmDateTimeField field,
  ) {
    state = state.copyWith(
      startTime: field == AlarmDateTimeField.startTime
          ? DateTime.now()
          : state.startTime,
      startDay: field == AlarmDateTimeField.startDay ? null : state.startDay,
      nextAlarm: field == AlarmDateTimeField.nextAlarm ? null : state.nextAlarm,
    );
  }

  void setRepeat(int repeat) {
    state = state.copyWith(repeat: repeat);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateNextAlarmTime({
    required int days,
  }) {
    // 만약에 nextAlarm 이 null 이 아니라면 days 기간을 추가한다
    final DateTime now = state.startTime;
    final DateTime? startDay = state.startDay;
    DateTime result = DateTime(
        startDay?.year ?? now.year,
        startDay?.month ?? now.month,
        startDay?.day ?? now.day,
        now.hour,
        now.minute,
        now.second);

    setDateTime(
      AlarmDateTimeField.startDay, // key 값을 문자열로 지정
      result,
    );
  }

  void setAlarm(Alarm? alarm) {
    if (alarm == null) {
      reset();
    } else {
      state = alarm;
    }
  }

  void reset() {
    state = Alarm(startTime: DateTime.now());
  }
}
