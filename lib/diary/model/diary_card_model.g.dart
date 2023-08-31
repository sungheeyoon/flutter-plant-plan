// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryCardModel _$$_DiaryCardModelFromJson(Map<String, dynamic> json) =>
    _$_DiaryCardModel(
      docId: json['docId'] as String,
      name: json['name'] as String,
      alias: json['alias'] as String,
      imageUrl: json['imageUrl'] as String,
      diary: DiaryModel.fromJson(json['diary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_DiaryCardModelToJson(_$_DiaryCardModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'name': instance.name,
      'alias': instance.alias,
      'imageUrl': instance.imageUrl,
      'diary': instance.diary,
    };
