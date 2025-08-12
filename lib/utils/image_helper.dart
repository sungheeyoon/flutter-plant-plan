import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
      : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;

  final ImageCropper _imageCropper;

  Future<XFile?> pickImage({
    bool camera = false,
    int imageQuality = 100,
  }) async {
    XFile? file;
    if (camera) {
      file = await _imagePicker.pickImage(
          source: ImageSource.camera, imageQuality: imageQuality);
    } else {
      file = await _imagePicker.pickImage(
          source: ImageSource.gallery, imageQuality: imageQuality);
    }

    if (file != null) {
      return file;
    }
    return null;
  }

  Future<CroppedFile?> crop({required XFile file}) async {
    return await ImageCropper().cropImage(
      sourcePath: file.path,
      maxHeight: 1000,
      maxWidth: 1000,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '이미지 자르기',
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          title: '이미지 자르기',
          aspectRatioLockEnabled: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
      ],
    );
  }
}
