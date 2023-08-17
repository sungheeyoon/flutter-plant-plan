import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

Reference get firebaseStorage => FirebaseStorage.instance.ref();

class FirebaseStorageService extends GetxService {
  Future<String?> getImage(String? imgName) async {
    if (imgName == null) {
      return null;
    }
    try {
      var urlRef =
          firebaseStorage.child('images').child('${imgName.toLowerCase()}.png');
      var imgUrl = await urlRef.getDownloadURL();
      return imgUrl;
    } catch (e) {
      return null;
    }
  }
}

Future<void> getAllImageUrls() async {
  List<String> imageUrls = [];

  Reference ref = FirebaseStorage.instance.ref().child('images');
  ListResult result = await ref.listAll();

  for (Reference imageRef in result.items) {
    String imageUrl = await imageRef.getDownloadURL();
    imageUrls.add(imageUrl);
  }

  print('yournewimage: $imageUrls');
}
