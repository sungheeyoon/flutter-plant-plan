import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plant_plan/add/model/plant_information_model.dart';

final dateTimeProvider = StateNotifierProvider<DateTimeNotifier, Alarm>((ref) {
  return DateTimeNotifier();
});

class DateTimeNotifier extends StateNotifier<Alarm> {
  DateTimeNotifier() : super(Alarm());

  void setDateTime(
    String key,
    DateTime time,
  ) {
    state = state.copyWith(
      startTime: key == 'startTime' ? time : state.startTime,
      startDay: key == 'startDay' ? time : state.startDay,
      nextAlarm: key == 'nextAlarm' ? time : state.nextAlarm,
    );
  }

  void setDateTimeNull(
    String key,
  ) {
    state = state.copyWith(
      startTime: key == 'startTime' ? null : state.startTime,
      startDay: key == 'startDay' ? null : state.startDay,
      nextAlarm: key == 'nextAlarm' ? null : state.nextAlarm,
    );
  }

  void setRepeat(int repeat) {
    state = state.copyWith(repeat: repeat);
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setNull(key) {
    //state = {...state, 바꾸고싶은 key : null}
  }

  void updateNextAlarmTime({
    required int days,
  }) {
    // 만약에 nextAlarm 이 null 이 아니라면 days 기간을 추가한다
    final DateTime now = state.startTime!;
    if (state.nextAlarm != null) {
      setDateTime(
        'nextAlarm', // key 값을 문자열로 지정
        now.add(
          Duration(days: days),
        ),
      );
    }
  }
}
