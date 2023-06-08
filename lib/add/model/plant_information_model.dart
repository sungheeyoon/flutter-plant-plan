import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    @TimestampSerializer() @Default(null) DateTime? lastDay,
    required Alarm alarm,
  }) = _PlantInformationKey;

  factory PlantInformationKey.fromJson(Map<String, dynamic> json) =>
      _$PlantInformationKeyFromJson(json);
}

@freezed
class Alarm with _$Alarm {
  factory Alarm({
    @TimestampSerializer() required DateTime startTime,
    @TimestampSerializer() @Default(null) DateTime? startDay,
    @TimestampSerializer() @Default(null) DateTime? nextAlarm,
    @Default(0) int repeat,
    @Default("") String title,
    @Default(true) bool isOn,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);
}

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
