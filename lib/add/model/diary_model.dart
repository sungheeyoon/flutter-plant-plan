import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/utils/timestamp_serializer.dart';
import 'package:uuid/uuid.dart';
part 'diary_model.freezed.dart';
part 'diary_model.g.dart';

@freezed
class DiaryModel with _$DiaryModel {
  factory DiaryModel({
    @Default('') String id,
    @TimestampSerializer() required DateTime date,
    @Default('') String emoji,
    @Default('') String title,
    @Default([]) List<String> imageUrl,
    @Default('') String context,
    @Default(false) bool bookMark,
  }) = _DiaryModel;

  factory DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryModelFromJson(json);

  factory DiaryModel.newDiaryModel({
    required DateTime date,
    String emoji = '',
    String title = '',
    List<String> imageUrl = const [],
    String context = '',
    bool bookMark = false,
  }) {
    return DiaryModel(
      id: const Uuid().v4(),
      date: date,
      emoji: emoji,
      title: title,
      imageUrl: imageUrl,
      context: context,
      bookMark: bookMark,
    );
  }
}
