import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDategState, DateTime>((ref) {
  return SelectedDategState();
});

class SelectedDategState extends StateNotifier<DateTime> {
  SelectedDategState()
      : super(
          DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          ),
        );

  void updateDateTime(DateTime newDateTime) {
    state = DateTime(
      newDateTime.year,
      newDateTime.month,
      newDateTime.day,
    );
  }
}
