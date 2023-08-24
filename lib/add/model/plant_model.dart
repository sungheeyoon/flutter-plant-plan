import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/model/alarm_model.dart';
import 'package:plant_plan/add/model/diary_model.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/common/utils/timestamp_serializer.dart';

part 'plant_model.freezed.dart';
part 'plant_model.g.dart';

@freezed
class PlantModel with _$PlantModel {
  factory PlantModel({
    @Default("") String docId,
    @Default("") String userImageUrl,
    @Default("") String alias,
    @Default(false) bool favorite,
    required InformationModel information,
    @Default([]) List<DiaryModel> diary,
    @Default([]) List<AlarmModel> alarms,
    @Default(null) @TimestampSerializer() DateTime? timestamp,
  }) = _PlantModel;

  factory PlantModel.fromJson(Map<String, dynamic> json) =>
      _$PlantModelFromJson(json);
}
