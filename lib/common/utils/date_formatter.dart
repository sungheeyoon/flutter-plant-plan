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
