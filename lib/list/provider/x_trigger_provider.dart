import 'package:flutter_riverpod/flutter_riverpod.dart';

final xTriggerProvider = StateNotifierProvider<XTriggerNotifier, bool>((ref) {
  return XTriggerNotifier();
});

class XTriggerNotifier extends StateNotifier<bool> {
  XTriggerNotifier() : super(false);

  void toggle() {
    state = !state;
  }

  void isTrue() {
    state = true;
  }

  void isFalse() {
    state = false;
  }
}
