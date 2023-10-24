import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final wateringProvider = StateProvider<bool>((ref) => true);
final repottingProvider = StateProvider<bool>((ref) => true);
final nutrientProvider = StateProvider<bool>((ref) => true);
final noticeProvider = StateProvider<bool>((ref) => true);

final wateringProviderFuture = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool('watering');
  if (value != null) {
    ref.read(wateringProvider.notifier).state = value;
  }
  return value ?? true;
});

final repottingProviderFuture = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool('repotting');
  if (value != null) {
    ref.read(repottingProvider.notifier).state = value;
  }
  return value ?? true;
});

final nutrientProviderFuture = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool('nutrient');
  if (value != null) {
    ref.read(nutrientProvider.notifier).state = value;
  }
  return value ?? true;
});

final noticeProviderFuture = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final value = prefs.getBool('notice');
  if (value != null) {
    ref.read(noticeProvider.notifier).state = value;
  }
  return value ?? true;
});
