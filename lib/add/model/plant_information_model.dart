import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant_information_model.freezed.dart';
part 'plant_information_model.g.dart';

@freezed
class PlantInformationModel with _$PlantInformationModel {
  factory PlantInformationModel({
    @Default("") String alias,
    required PlantInformationKey watering,
    required PlantInformationKey repotting,
    required PlantInformationKey nutrient,
  }) = _PlantInformationModel;

  factory PlantInformationModel.fromJson(Map<String, dynamic> json) =>
      _$PlantInformationModelFromJson(json);
}

@freezed
class PlantInformationKey with _$PlantInformationKey {
  factory PlantInformationKey({
    @Default("") String day,
    required Alarm alarm,
  }) = _PlantInformationKey;

  factory PlantInformationKey.fromJson(Map<String, dynamic> json) =>
      _$PlantInformationKeyFromJson(json);
}

@freezed
class Alarm with _$Alarm {
  factory Alarm({
    @Default("") String startDate,
    @Default(0) int repeat,
    @Default("") String title,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}
