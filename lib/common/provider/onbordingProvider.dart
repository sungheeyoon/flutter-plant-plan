import 'package:flutter_riverpod/flutter_riverpod.dart';

final onboardingProvider = StateNotifierProvider<OnboardingState, int>((ref) {
  return OnboardingState();
});

class OnboardingState extends StateNotifier<int> {
  OnboardingState() : super(0);

  void changePage(int i) => state = i;
}
