import 'package:json_annotation/json_annotation.dart';

part 'plant_model.g.dart';

abstract class PlantModelBase {}

class PlantModelError extends PlantModelBase {
  final String message;

  PlantModelError({
    required this.message,
  });
}

class PlantModelLoading extends PlantModelBase {}

@JsonSerializable()
class PlantModel extends PlantModelBase {
  final int id;
  final String name;
  final String imageUrl;

  PlantModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory PlantModel.fromJson(Map<String, dynamic> json) =>
      _$PlantModelFromJson(json);
}
