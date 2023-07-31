// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AlarmModel _$$_AlarmModelFromJson(Map<String, dynamic> json) =>
    _$_AlarmModel(
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

Map<String, dynamic> _$$_AlarmModelToJson(_$_AlarmModel instance) =>
    <String, dynamic>{
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
  PlantField.none: 'none',
};
