// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InformationModel _$$_InformationModelFromJson(Map<String, dynamic> json) =>
    _$_InformationModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      imageUrl: json['imageUrl'] as String? ?? '',
      tips: (json['tips'] as List<dynamic>?)
              ?.map((e) => TipModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_InformationModelToJson(_$_InformationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'tips': instance.tips,
    };
