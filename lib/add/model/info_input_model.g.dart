// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_input_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InfoInputModel _$$_InfoInputModelFromJson(Map<String, dynamic> json) =>
    _$_InfoInputModel(
      alias: json['alias'] as String? ?? "",
      wateringDay: json['wateringDay'] as String? ?? "",
      repottingDay: json['repottingDay'] as String? ?? "",
      nutrientDay: json['nutrientDay'] as String? ?? "",
    );

Map<String, dynamic> _$$_InfoInputModelToJson(_$_InfoInputModel instance) =>
    <String, dynamic>{
      'alias': instance.alias,
      'wateringDay': instance.wateringDay,
      'repottingDay': instance.repottingDay,
      'nutrientDay': instance.nutrientDay,
    };
