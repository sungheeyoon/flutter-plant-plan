// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PlantInformationModel _$$_PlantInformationModelFromJson(
        Map<String, dynamic> json) =>
    _$_PlantInformationModel(
      alias: json['alias'] as String? ?? "",
      watringLastDay: json['watringLastDay'] == null
          ? null
          : const TimestampSerializer().fromJson(json['watringLastDay']),
      repottingLastDay: json['repottingLastDay'] == null
          ? null
          : const TimestampSerializer().fromJson(json['repottingLastDay']),
      nutrientLastDay: json['nutrientLastDay'] == null
          ? null
          : const TimestampSerializer().fromJson(json['nutrientLastDay']),
      alarms: (json['alarms'] as List<dynamic>?)
              ?.map((e) => Alarm.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$_PlantInformationModelToJson(
        _$_PlantInformationModel instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'watringLastDay': _$JsonConverterToJson<dynamic, DateTime>(
          instance.watringLastDay, const TimestampSerializer().toJson),
      'repottingLastDay': _$JsonConverterToJson<dynamic, DateTime>(
          instance.repottingLastDay, const TimestampSerializer().toJson),
      'nutrientLastDay': _$JsonConverterToJson<dynamic, DateTime>(
          instance.nutrientLastDay, const TimestampSerializer().toJson),
      'alarms': instance.alarms,
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
      isOn: json['isOn'] as bool? ?? false,
      offDates: (json['offDates'] as List<dynamic>?)
              ?.map((e) => DateTime.parse(e as String))
              .toList() ??
          const [],
      field: $enumDecode(_$PlantFieldEnumMap, json['field']),
    );

Map<String, dynamic> _$$_AlarmToJson(_$_Alarm instance) => <String, dynamic>{
      'id': instance.id,
      'startTime': const TimestampSerializer().toJson(instance.startTime),
      'repeat': instance.repeat,
      'title': instance.title,
      'isOn': instance.isOn,
      'offDates': instance.offDates.map((e) => e.toIso8601String()).toList(),
      'field': _$PlantFieldEnumMap[instance.field]!,
    };

const _$PlantFieldEnumMap = {
  PlantField.watering: 'watering',
  PlantField.repotting: 'repotting',
  PlantField.nutrient: 'nutrient',
};
