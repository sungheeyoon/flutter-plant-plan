// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfoModel _$$_UserInfoModelFromJson(Map<String, dynamic> json) =>
    _$_UserInfoModel(
      info:
          PlantInformationModel.fromJson(json['info'] as Map<String, dynamic>),
      plant: PlantModel.fromJson(json['plant'] as Map<String, dynamic>),
      selectedPhotoUrl: json['selectedPhotoUrl'] as String,
    );

Map<String, dynamic> _$$_UserInfoModelToJson(_$_UserInfoModel instance) =>
    <String, dynamic>{
      'info': instance.info,
      'plant': instance.plant,
      'selectedPhotoUrl': instance.selectedPhotoUrl,
    };
