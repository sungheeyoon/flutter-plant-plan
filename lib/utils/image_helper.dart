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
    int imageQuality = 20,
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

  Future<CroppedFile?> crop(
          {required XFile file,
          CropStyle cropStyle = CropStyle.rectangle}) async =>
      await _imageCropper.cropImage(
        sourcePath: file.path,
        cropStyle: cropStyle,
      );
}
