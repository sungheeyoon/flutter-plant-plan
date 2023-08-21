import 'package:plant_plan/add/model/plant_model.dart';

abstract class DetailModelBase {}

class DetailModelError extends DetailModelBase {
  final String message;

  DetailModelError({
    required this.message,
  });
}

class DetailModelLoading extends DetailModelBase {}

class DetailModel extends DetailModelBase {
  final PlantModel data;

  DetailModel({
    required this.data,
  });
}
