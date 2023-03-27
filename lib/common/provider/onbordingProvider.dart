import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider<onboardingState, int>((ref) {
  return onboardingState();
});

class onboardingState extends StateNotifier<int> {
  onboardingState() : super(0);

  void changePage(int i) => state = i;
}
