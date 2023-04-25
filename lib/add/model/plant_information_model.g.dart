// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlantInformationModel _$$_PlantInformationModelFromJson(
        Map<String, dynamic> json) =>
    _$_PlantInformationModel(
      alias: json['alias'] as String? ?? "",
      watering: PlantInformationKey.fromJson(
          json['watering'] as Map<String, dynamic>),
      repotting: PlantInformationKey.fromJson(
          json['repotting'] as Map<String, dynamic>),
      nutrient: PlantInformationKey.fromJson(
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
      day: json['day'] as String? ?? "",
      alarm: Alarm.fromJson(json['alarm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlantInformationKeyToJson(
        _$_PlantInformationKey instance) =>
    <String, dynamic>{
      'day': instance.day,
      'alarm': instance.alarm,
    };

_$_Alarm _$$_AlarmFromJson(Map<String, dynamic> json) => _$_Alarm(
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      startDay: json['startDay'] as String? ?? "",
      repeat: json['repeat'] as int? ?? 0,
      title: json['title'] as String? ?? "",
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'startDate': instance.startDate?.toIso8601String(),
      'startDay': instance.startDay,
      'repeat': instance.repeat,
      'title': instance.title,
    };
