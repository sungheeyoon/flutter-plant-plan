import 'package:plant_plan/add/model/plant_information_model.dart';
import 'package:plant_plan/add/model/plant_model.dart';

class AlarmWithUserInfo {
  final Alarm alarm;
  final String alias;
  final PlantModel plant;
  final String selectedPhotoUrl;
  final String docId;

  AlarmWithUserInfo({
    required this.alarm,
    required this.alias,
    required this.plant,
    required this.selectedPhotoUrl,
    required this.docId,
  });
}
