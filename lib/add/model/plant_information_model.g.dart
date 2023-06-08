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
          : const TimestampSerializer().fromJson(json['lastDay']),
      alarm: Alarm.fromJson(json['alarm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PlantInformationKeyToJson(
        _$_PlantInformationKey instance) =>
    <String, dynamic>{
      'lastDay': _$JsonConverterToJson<dynamic, DateTime>(
          instance.lastDay, const TimestampSerializer().toJson),
      'alarm': instance.alarm,
    };

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$_Alarm _$$_AlarmFromJson(Map<String, dynamic> json) => _$_Alarm(
      startTime: const TimestampSerializer().fromJson(json['startTime']),
      startDay: json['startDay'] == null
          ? null
          : const TimestampSerializer().fromJson(json['startDay']),
      nextAlarm: json['nextAlarm'] == null
          ? null
          : const TimestampSerializer().fromJson(json['nextAlarm']),
      repeat: json['repeat'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      isOn: json['isOn'] as bool? ?? true,
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'startTime': const TimestampSerializer().toJson(instance.startTime),
      'startDay': _$JsonConverterToJson<dynamic, DateTime>(
          instance.startDay, const TimestampSerializer().toJson),
      'nextAlarm': _$JsonConverterToJson<dynamic, DateTime>(
          instance.nextAlarm, const TimestampSerializer().toJson),
      'repeat': instance.repeat,
      'title': instance.title,
      'isOn': instance.isOn,
    };
