import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plant_plan/add/model/tip_model.dart';

part 'information_model.freezed.dart';
part 'information_model.g.dart';

@freezed
class InformationModel with _$InformationModel {
  factory InformationModel({
    @Default('') String id,
    @Default('') String name,
    @Default('') String imageUrl,
    @Default([]) List<TipModel> tips,
  }) = _InformationModel;

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);

  // Tips를 구체화해서 모양을 잡아놓을지 아니면 빈어레이로둘지 결정중.
  // factory InformationModel.withDefaultTips({
  //   String id = '',
  //   String name = '',
  //   String imageUrl = '',
  // }) =>
  //     InformationModel(
  //       id: id,
  //       name: name,
  //       imageUrl: imageUrl,
  //       tips: [

  //       ]
  //     );
}
