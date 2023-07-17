import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/provider/plant_information_provider.dart';

part 'list_card_model.freezed.dart';
part 'list_card_model.g.dart';

@freezed
class ListCardModel with _$ListCardModel {
  factory ListCardModel({
    required String title,
    required String imageUrl,
    required int dDay,
    required List<PlantField> fields,
  }) = _ListCardModel;

  factory ListCardModel.fromJson(Map<String, dynamic> json) =>
      _$ListCardModelFromJson(json);
}
