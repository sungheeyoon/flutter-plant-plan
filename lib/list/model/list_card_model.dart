import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/utils/timestamp_serializer.dart';

part 'list_card_model.freezed.dart';
part 'list_card_model.g.dart';

@freezed
class ListCardModel with _$ListCardModel {
  factory ListCardModel({
    required String docId,
    required String title,
    required String imageUrl,
    required int dDay,
    required List<PlantField> fields,
    required bool favorite,
    @TimestampSerializer() required DateTime timestamp,
  }) = _ListCardModel;

  factory ListCardModel.fromJson(Map<String, dynamic> json) =>
      _$ListCardModelFromJson(json);
}
