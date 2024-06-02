import 'package:intl/intl.dart';

String dateFormatter(DateTime time) {
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  return dateFormat.format(time);
}

String nextAlarmFomattor(DateTime time) {
  String nextDate = "${time.month}월 ${time.day}일";
  String nextTime = "${time.hour}시 ${time.minute}분";

  // 다음 알림 텍스트 업데이트
  return "다음 알림은 $nextDate $nextTime 입니다.";
}

String formatTime(DateTime dateTime) {
  String period = dateTime.hour < 12 ? 'AM' : 'PM';
  int hour = dateTime.hour % 12;
  if (hour == 0) hour = 12;
  String minute = dateTime.minute.toString().padLeft(2, '0');
  return '$hour:$minute $period';
}

String formatKoreanTime(DateTime dateTime) {
  String period = "오전";
  int hour = dateTime.hour;
  int minute = dateTime.minute;

  if (hour >= 12) {
    period = "오후";
    if (hour > 12) {
      hour -= 12;
    }
  }

  if (hour == 0) {
    hour = 12;
  }

  String formattedMinute = minute < 10 ? "0$minute" : "$minute";

  return "$period $hour:$formattedMinute";
}

DateTime? findEarliestDate(List<DateTime> offDates) {
  if (offDates.isEmpty) {
    return null;
  }

  DateTime earliestDate = offDates.reduce((currentDate, nextDate) {
    return currentDate.isBefore(nextDate) ? nextDate : currentDate;
  });

  // 년,월,일만사용
  earliestDate = DateTime(
    earliestDate.year,
    earliestDate.month,
    earliestDate.day,
  );

  return earliestDate;
}

int calculateDateDifferenceInDays(DateTime startDate, DateTime endDate) {
  // 년,월,일만사용
  final start = DateTime(startDate.year, startDate.month, startDate.day);
  final end = DateTime(endDate.year, endDate.month, endDate.day);

  // 밀리초 단위로 두 날짜 간의 차이를 계산
  final differenceInMilliseconds = end.difference(start).inMilliseconds;

  // 차이를 일로 변환. 1일은 24시간이므로 1000 밀리초 * 60 초 * 60 분 * 24 시간을 사용하여 계산
  final differenceInDays =
      (differenceInMilliseconds / (1000 * 60 * 60 * 24)).abs();

  // 소수점 이하의 일 수를 반올림하여 반환.
  return differenceInDays.round();
}
