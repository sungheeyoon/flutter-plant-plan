import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/utils/timestamp_serializer.dart';
import 'package:uuid/uuid.dart';
part 'alarm_model.freezed.dart';
part 'alarm_model.g.dart';

@freezed
class AlarmModel with _$AlarmModel {
  factory AlarmModel({
    @Default('') String id,
    @TimestampSerializer() required DateTime startTime,
    @Default(0) int repeat,
    @Default('') String title,
    @Default(true) bool isOn,
    @Default([]) List<DateTime> offDates,
    required PlantField field, // nutrient, watering, repotting 중 하나의 필드
  }) = _AlarmModel;

  factory AlarmModel.fromJson(Map<String, dynamic> json) =>
      _$AlarmModelFromJson(json);

  factory AlarmModel.newAlarmModel({
    required DateTime startTime,
    int repeat = 0,
    String title = '',
    bool isOn = true,
    List<DateTime> offDates = const [],
    required PlantField field,
  }) {
    return AlarmModel(
      id: const Uuid().v4(),
      startTime: startTime,
      repeat: repeat,
      title: title,
      isOn: isOn,
      offDates: offDates,
      field: field,
    );
  }
}
