import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_plan/utils/image_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart' as path;

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
  Future<void> setNewPhoto({required bool camera}) async {
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

  Future<String> uploadPhotoAndGetUserImageUrl() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) return "";

    final uid = user.uid;
    final FirebaseStorage storage = FirebaseStorage.instance;
    if (state == null) {
      return '';
    } else {
      String fileName = path.basename(state!.path);
      Reference storageRef = storage.ref().child('users/$uid/$fileName');
      UploadTask uploadTask = storageRef.putFile(state!);

      TaskSnapshot snapshot = await uploadTask.whenComplete(() => null);
      String userImageUrl = await snapshot.ref.getDownloadURL();

      return userImageUrl;
    }
  }

  Future<void> deleteImage(String imageUrl) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) return;

    final FirebaseStorage storage = FirebaseStorage.instance;

    Reference imageRef = storage.refFromURL(imageUrl);

    try {
      await imageRef.delete();
      print("Image deleted successfully");
    } catch (error) {
      print("Error deleting image: $error");
    }
  }
}
