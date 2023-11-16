import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/utils/timestamp_serializer.dart';
part 'announcement_model.freezed.dart';
part 'announcement_model.g.dart';

@freezed
class AnnouncementModel with _$AnnouncementModel {
  factory AnnouncementModel({
    required String title,
    @TimestampSerializer() required DateTime date,
    required bool isNew,
    required String body,
    @Default(false) bool isExpanded,
  }) = _AnnouncementModel;

  factory AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementModelFromJson(json);
}
