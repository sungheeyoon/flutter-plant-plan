// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ListCardModel _$$_ListCardModelFromJson(Map<String, dynamic> json) =>
    _$_ListCardModel(
      docId: json['docId'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      dDay: json['dDay'] as int,
      fields: (json['fields'] as List<dynamic>)
          .map((e) => $enumDecode(_$PlantFieldEnumMap, e))
          .toList(),
      favorite: json['favorite'] as bool,
      timestamp: const TimestampSerializer().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$_ListCardModelToJson(_$_ListCardModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'dDay': instance.dDay,
      'fields': instance.fields.map((e) => _$PlantFieldEnumMap[e]!).toList(),
      'favorite': instance.favorite,
      'timestamp': const TimestampSerializer().toJson(instance.timestamp),
    };

const _$PlantFieldEnumMap = {
  PlantField.watering: 'watering',
  PlantField.repotting: 'repotting',
  PlantField.nutrient: 'nutrient',
  PlantField.none: 'none',
};
