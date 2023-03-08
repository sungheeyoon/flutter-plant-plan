import 'package:freezed_annotation/freezed_annotation.dart';

part 'plant.g.dart';
part 'plant.freezed.dart';

@Freezed()
class Plant with _$Plant {
  factory Plant({
    required int id,
    required String name,
    required String imageUrl,
  }) = _Plant;

  factory Plant.fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);
}
