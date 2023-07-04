import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
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
    @Default('') String id,
    @TimestampSerializer() required DateTime startTime,
    @Default(0) int repeat,
    @Default('') String title,
    @Default(false) bool isOn,
    @Default([]) List<DateTime> offDates,
  }) = _Alarm;

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  factory Alarm.newAlarm({
    required DateTime startTime,
    int repeat = 0,
    String title = '',
    bool isOn = false,
    List<DateTime> offDates = const [],
  }) {
    return Alarm(
      id: const Uuid().v4(),
      startTime: startTime,
      repeat: repeat,
      title: title,
      isOn: isOn,
      offDates: offDates,
    );
  }
}

class TimestampSerializer implements JsonConverter<DateTime, dynamic> {
  const TimestampSerializer();

  @override
  DateTime fromJson(dynamic timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
