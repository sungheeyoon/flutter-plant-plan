import 'package:image_picker/image_picker.dart';

class PreserveModel {
  PreserveModel({
    required this.image,
    required this.alias,
    required this.wateringDay,
    required this.repottingDay,
    required this.nutrientDay,
  });

  XFile? image;
  String? alias;
  String? wateringDay;
  String? repottingDay;
  String? nutrientDay;

  factory PreserveModel.fromJson(Map<String, dynamic> doc) {
    return PreserveModel(
      image: doc['image'],
      alias: doc['alias'],
      wateringDay: doc['wateringDay'],
      repottingDay: doc['repottingDay'],
      nutrientDay: doc['nutrientDay'],
    );
  }
}
