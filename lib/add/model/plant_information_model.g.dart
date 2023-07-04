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
      id: json['id'] as String? ?? '',
      startTime: const TimestampSerializer().fromJson(json['startTime']),
      repeat: json['repeat'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      isOn: json['isOn'] as bool? ?? true,
      offDates: (json['offDates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': const TimestampSerializer().toJson(instance.startTime),
      'repeat': instance.repeat,
      'title': instance.title,
      'isOn': instance.isOn,
      'offDates': instance.offDates.map((e) => e.toIso8601String()).toList(),
    };
