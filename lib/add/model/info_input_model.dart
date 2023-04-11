import 'package:freezed_annotation/freezed_annotation.dart';

part 'info_input_model.g.dart';
part 'info_input_model.freezed.dart';

abstract class InfoBase {
  String? get alias;
  String? get wateringDay;
  String? get divisionDay;
  String? get nutrientDay;
}

@freezed
class InfoInputModel with _$InfoInputModel {
  @Implements<InfoBase>()
  const factory InfoInputModel({
    final String? alias,
    final String? wateringDay,
    final String? divisionDay,
    final String? nutrientDay,
  }) = _InfoInputModel;

  factory InfoInputModel.fromJson(Map<String, dynamic> json) =>
      _$InfoInputModelFromJson(json);
}
