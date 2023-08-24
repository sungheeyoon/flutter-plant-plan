// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlantModel _$$_PlantModelFromJson(Map<String, dynamic> json) =>
    _$_PlantModel(
      docId: json['docId'] as String? ?? "",
      userImageUrl: json['userImageUrl'] as String? ?? "",
      alias: json['alias'] as String? ?? "",
      favorite: json['favorite'] as bool? ?? false,
      information: InformationModel.fromJson(
          json['information'] as Map<String, dynamic>),
      diary: (json['diary'] as List<dynamic>?)
              ?.map((e) => DiaryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      alarms: (json['alarms'] as List<dynamic>?)
              ?.map((e) => AlarmModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      timestamp: json['timestamp'] == null
          ? null
          : const TimestampSerializer().fromJson(json['timestamp']),
    );

Map<String, dynamic> _$$_PlantModelToJson(_$_PlantModel instance) =>
    <String, dynamic>{
      'docId': instance.docId,
      'userImageUrl': instance.userImageUrl,
      'alias': instance.alias,
      'favorite': instance.favorite,
      'information': instance.information,
      'diary': instance.diary,
      'alarms': instance.alarms,
      'timestamp': _$JsonConverterToJson<dynamic, DateTime>(
          instance.timestamp, const TimestampSerializer().toJson),
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
