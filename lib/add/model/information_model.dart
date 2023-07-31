import 'package:json_annotation/json_annotation.dart';

part 'information_model.g.dart';

abstract class InformationModelBase {}

class InformationModelError extends InformationModelBase {
  final String message;

  InformationModelError({
    required this.message,
  });
}

class InformationModelLoading extends InformationModelBase {}

@JsonSerializable()
class InformationModel extends InformationModelBase {
  final int id;
  final String name;
  final String imageUrl;

  InformationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory InformationModel.fromJson(Map<String, dynamic> json) =>
      _$InformationModelFromJson(json);

  Map<String, dynamic> toJson() => _$InformationModelToJson(this);
}
