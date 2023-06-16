import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedDateProvider =
    StateNotifierProvider<SelectedDategState, DateTime>((ref) {
  return SelectedDategState();
});

class SelectedDategState extends StateNotifier<DateTime> {
  SelectedDategState() : super(DateTime.now());

  void updateDateTime(DateTime newDateTime) {
    state = newDateTime;
  }
}
