import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/model/tip_model.dart';

part 'information_model.freezed.dart';
part 'information_model.g.dart';

@freezed
class InformationModel with _$InformationModel {
  @JsonSerializable(explicitToJson: true)
  factory InformationModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String imageUrl,
    @Default([]) List<TipModel> tips,
  }) = _InformationModel;

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);
}
