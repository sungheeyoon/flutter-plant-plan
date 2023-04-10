import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final photoProvider = StateNotifierProvider<PhotoNotifier, File?>((ref) {
  return PhotoNotifier();
});

class PhotoNotifier extends StateNotifier<File?> {
  PhotoNotifier() : super(null);
  void setPhoto(String path) {
    final pickedPhoto = XFile(path);
    state = File(pickedPhoto.path);
  }

  void reset() {
    state = null;
  }
}
