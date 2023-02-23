import 'package:image_picker/image_picker.dart';

class PreserveModel {
  PreserveModel({
    required this.image,
    required this.alias,
    required this.wateringDay,
    required this.divisionDay,
    required this.nutrientDay,
  });

  XFile? image;
  String? alias;
  String? wateringDay;
  String? divisionDay;
  String? nutrientDay;

  factory PreserveModel.fromJson(Map<String, dynamic> doc) {
    return PreserveModel(
      image: doc['image'],
      alias: doc['alias'],
      wateringDay: doc['wateringDay'],
      divisionDay: doc['divisionDay'],
      nutrientDay: doc['nutrientDay'],
    );
  }
}
