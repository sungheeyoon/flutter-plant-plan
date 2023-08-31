import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/model/diary_model.dart';

part 'diary_card_model.freezed.dart';
part 'diary_card_model.g.dart';

@freezed
class DiaryCardModel with _$DiaryCardModel {
  factory DiaryCardModel({
    required String docId,
    required String name,
    required String alias,
    required String imageUrl,
    required DiaryModel diary,
  }) = _DiaryCardModel;

  factory DiaryCardModel.fromJson(Map<String, dynamic> json) =>
      _$DiaryCardModelFromJson(json);
}
