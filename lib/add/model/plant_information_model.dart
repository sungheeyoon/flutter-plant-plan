import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_information_model.freezed.dart';
part 'plant_information_model.g.dart';

@freezed
class PlantInformationModel with _$PlantInformationModel {
  factory PlantInformationModel({
    String? alias,
    PlantInformationKey? watering,
    PlantInformationKey? repotting,
    PlantInformationKey? nutrient,
  }) = _PlantInformationModel;

  factory PlantInformationModel.fromJson(Map<String, dynamic> json) =>
      _$PlantInformationModelFromJson(json);
}

@freezed
class PlantInformationKey with _$PlantInformationKey {
  factory PlantInformationKey({
    DateTime? day,
    Alarm? alarm,
  }) = _PlantInformationKey;

  factory PlantInformationKey.fromJson(Map<String, dynamic> json) =>
      _$PlantInformationKeyFromJson(json);
}

@freezed
class Alarm with _$Alarm {
  factory Alarm({
    DateTime? startDate,
    int? repeat,
    String? title,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}
