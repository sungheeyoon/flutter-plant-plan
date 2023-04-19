import 'package:flutter_riverpod/flutter_riverpod.dart';

enum DateTimeKey { now, calculatedTime }

final dateTimeProvider =
    StateNotifierProvider<DateTimeNotifier, Map<DateTimeKey, DateTime?>>((ref) {
  return DateTimeNotifier();
});

class DateTimeNotifier extends StateNotifier<Map<DateTimeKey, DateTime?>> {
  DateTimeNotifier()
      : super({
          DateTimeKey.now: DateTime.now(),
          DateTimeKey.calculatedTime: null
        });

  void setDateTime(DateTimeKey key, DateTime time) {
    state = {...state, key: time};
  }

  void setCalculatedTimeNull() {
    state = {...state, DateTimeKey.calculatedTime: null};
  }

  void updateNextAlarmTime({
    required int focusedButtonIndex,
    int? days,
  }) {
    final DateTime now = state[DateTimeKey.now]!;
    switch (focusedButtonIndex) {
      case 0: // '매일' 버튼
        setDateTime(
          DateTimeKey.calculatedTime,
          now.add(
            const Duration(days: 1),
          ),
        );

        break;
      case 1: // '매주' 버튼
        setDateTime(
          DateTimeKey.calculatedTime,
          now.add(
            const Duration(days: 7),
          ),
        );
        break;
      case 2: // '매월' 버튼
        int year = now.year;
        int month = now.month + 1;
        int day = now.day;
        int hour = now.hour;
        int minute = now.minute;
        if (month > 12) {
          year += 1;
          month = 1;
        }
        int lastDayOfMonth = DateTime(year, month + 1, 0).day;
        day = day <= lastDayOfMonth ? day : lastDayOfMonth;
        setDateTime(
          DateTimeKey.calculatedTime,
          DateTime(year, month, day, hour, minute),
        );

        break;
      case 3: // '직접 입력' 버튼
        if (days != null) {
          setDateTime(
            DateTimeKey.calculatedTime,
            now.add(
              Duration(days: days),
            ),
          );
        } else {
          // days가 null인 경우에는 _dateTime을 업데이트하지 않고 기존 값을 유지함
        }
        break;
    }
  }
}
