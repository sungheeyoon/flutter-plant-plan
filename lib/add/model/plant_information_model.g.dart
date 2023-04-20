// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlantInformationModel _$$_PlantInformationModelFromJson(
        Map<String, dynamic> json) =>
    _$_PlantInformationModel(
      alias: json['alias'] as String?,
      watering: json['watering'] == null
          ? null
          : PlantInformationKey.fromJson(
              json['watering'] as Map<String, dynamic>),
      repotting: json['repotting'] == null
          ? null
          : PlantInformationKey.fromJson(
              json['repotting'] as Map<String, dynamic>),
      nutrient: json['nutrient'] == null
          ? null
          : PlantInformationKey.fromJson(
              json['nutrient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlantInformationModelToJson(
        _$_PlantInformationModel instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'watering': instance.watering,
      'repotting': instance.repotting,
      'nutrient': instance.nutrient,
    };

_$_PlantInformationKey _$$_PlantInformationKeyFromJson(
        Map<String, dynamic> json) =>
    _$_PlantInformationKey(
      day: json['day'] == null ? null : DateTime.parse(json['day'] as String),
      alarm: json['alarm'] == null
          ? null
          : Alarm.fromJson(json['alarm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlantInformationKeyToJson(
        _$_PlantInformationKey instance) =>
    <String, dynamic>{
      'day': instance.day?.toIso8601String(),
      'alarm': instance.alarm,
    };

_$_Alarm _$$_AlarmFromJson(Map<String, dynamic> json) => _$_Alarm(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      repeat: json['repeat'] as int?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'repeat': instance.repeat,
      'title': instance.title,
    };
