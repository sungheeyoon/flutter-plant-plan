import 'package:plant_plan/add/model/plant_model.dart';

abstract class PlantsModelBase {}

class PlantsModelError extends PlantsModelBase {
  final String message;

  PlantsModelError({
    required this.message,
  });
}

class PlantsModelLoading extends PlantsModelBase {}

class PlantsModel extends PlantsModelBase {
  final List<PlantModel> data;

  PlantsModel({
    required this.data,
  });
}
