// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfoModel _$$_UserInfoModelFromJson(Map<String, dynamic> json) =>
    _$_UserInfoModel(
      plantInfo: PlantInformationModel.fromJson(
          json['plantInfo'] as Map<String, dynamic>),
      plant: PlantModel.fromJson(json['plant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserInfoModelToJson(_$_UserInfoModel instance) =>
    <String, dynamic>{
      'plantInfo': instance.plantInfo,
      'plant': instance.plant,
    };
