import 'dart:io';

import 'package:get/get.dart';

class AddScreenController extends GetxController {
  File img = File("assets/images/pot.png");
  RxString name = "".obs;
  RxString humid = "".obs;
  RxString repotting = "".obs;
  RxString nutrient = "".obs;

  void updateImage(File image) {
    img = image;
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
