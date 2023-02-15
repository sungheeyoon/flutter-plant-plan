import 'package:get/get.dart';
import 'package:plant_plan/services/firebase_storage_service.dart';

class PlantsImageController extends GetxController {
  final allPlantImages = <String>[].obs;
  @override
  void onReady() {
    getAllPlantImages();
    super.onReady();
  }

  Future<void> getAllPlantImages() async {
    List<String> imgName = ['a', 'b', 'c', 'd'];
    try {
      for (var img in imgName) {
        final imgUrl = await Get.find<FirebaseStorageService>().getImage(img);
        allPlantImages.add(imgUrl!);
      }
    } catch (e) {
      print(e);
    }
  }
}
