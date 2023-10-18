import 'package:freezed_annotation/freezed_annotation.dart';

part 'tip_model.freezed.dart';
part 'tip_model.g.dart';

@freezed
class TipModel with _$TipModel {
  factory TipModel({
    @Default('') String part,
    @Default('') String context,
  }) = _TipModel;

  factory TipModel.fromJson(Map<String, dynamic> json) =>
      _$TipModelFromJson(json);
}
