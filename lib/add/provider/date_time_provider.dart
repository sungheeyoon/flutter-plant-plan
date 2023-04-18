import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateTimeProvider =
    StateNotifierProvider<DateTimeNotifier, DateTime>((ref) {
  return DateTimeNotifier();
});

class DateTimeNotifier extends StateNotifier<DateTime> {
  DateTimeNotifier() : super(DateTime.now());
  void setDateTime(DateTime time) {
    state = time;
  }
}
