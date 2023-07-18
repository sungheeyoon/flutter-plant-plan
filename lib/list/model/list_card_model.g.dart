// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ListCardModel _$$_ListCardModelFromJson(Map<String, dynamic> json) =>
    _$_ListCardModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      dDay: json['dDay'] as int,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => $enumDecode(_$PlantFieldEnumMap, e))
          .toList(),
    );

Map<String, dynamic> _$$_ListCardModelToJson(_$_ListCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'dDay': instance.dDay,
      'fields': instance.fields.map((e) => _$PlantFieldEnumMap[e]!).toList(),
    };

const _$PlantFieldEnumMap = {
  PlantField.watering: 'watering',
  PlantField.repotting: 'repotting',
  PlantField.nutrient: 'nutrient',
  PlantField.none: 'none',
};
