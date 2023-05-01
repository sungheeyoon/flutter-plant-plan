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
      lastDay: json['lastDay'] == null
          ? null
          : DateTime.parse(json['lastDay'] as String),
      alarm: Alarm.fromJson(json['alarm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlantInformationKeyToJson(
        _$_PlantInformationKey instance) =>
    <String, dynamic>{
      'lastDay': instance.lastDay?.toIso8601String(),
      'alarm': instance.alarm,
    };

_$_Alarm _$$_AlarmFromJson(Map<String, dynamic> json) => _$_Alarm(
      startTime: DateTime.parse(json['startTime'] as String),
      startDay: json['startDay'] == null
          ? null
          : DateTime.parse(json['startDay'] as String),
      nextAlarm: json['nextAlarm'] == null
          ? null
          : DateTime.parse(json['nextAlarm'] as String),
      repeat: json['repeat'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      isOn: json['isOn'] as bool? ?? true,
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'startTime': instance.startTime.toIso8601String(),
      'startDay': instance.startDay?.toIso8601String(),
      'nextAlarm': instance.nextAlarm?.toIso8601String(),
      'repeat': instance.repeat,
      'title': instance.title,
      'isOn': instance.isOn,
    };
