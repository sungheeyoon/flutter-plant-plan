import 'dart:io';

import 'package:get/get.dart';

class AddScreenController extends GetxController {
  File? image;
  RxString name = "".obs;
  RxString humid = "".obs;
  RxString division = "".obs;
  RxString nutrient = "".obs;

  void updateImage(File image) {
    image = image;
    update();
  }

  void updateName(String name) {
    name = name;
  }

  // void updateImage(String image){
  //   image = image;
  //   update();
  // }

  // void updateImage(String image){
  //   image = image;
  //   update();
  // }

  // void updateImage(String image){
  //   image = image;
  //   update();
  // }

  // void updateImage(String image){
  //   image = image;
  //   update();
  // }
}
