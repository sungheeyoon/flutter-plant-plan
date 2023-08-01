import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/utils/image_helper.dart';

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

  //setPhoto 로 전환예정 test필요
  void setNewPhoto({required bool camera}) async {
    final imageHelper = ImageHelper();
    final file = camera
        ? await imageHelper.pickImage(camera: true)
        : await imageHelper.pickImage();

    if (file != null) {
      final croppedFile =
          await imageHelper.crop(file: file, cropStyle: CropStyle.circle);
      if (croppedFile != null) {
        final pickedPhoto = XFile(croppedFile.path);
        state = File(pickedPhoto.path);
      }
    }
  }
}
