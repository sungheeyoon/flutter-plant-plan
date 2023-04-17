import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_input_model.g.dart';
part 'info_input_model.freezed.dart';

enum InfoKey {
  alias,
  wateringDay,
  repottingDay,
  nutrientDay,
}

@freezed
class InfoInputModel with _$InfoInputModel {
  const factory InfoInputModel({
    @Default("") String alias,
    @Default("") String wateringDay,
    @Default("") String repottingDay,
    @Default("") String nutrientDay,
  }) = _InfoInputModel;

  factory InfoInputModel.fromJson(Map<String, dynamic> json) =>
      _$InfoInputModelFromJson(json);

  factory InfoInputModel.fromKeyValue({
    required InfoKey key,
    required String value,
  }) {
    switch (key) {
      case InfoKey.alias:
        return InfoInputModel(alias: value);
      case InfoKey.wateringDay:
        return InfoInputModel(wateringDay: value);
      case InfoKey.repottingDay:
        return InfoInputModel(repottingDay: value);
      case InfoKey.nutrientDay:
        return InfoInputModel(nutrientDay: value);
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}
