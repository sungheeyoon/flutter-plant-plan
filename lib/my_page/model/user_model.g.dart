// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      email: json['email'] as String,
      username: json['username'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'username': instance.username,
      'runtimeType': instance.$type,
    };

_$_UserModelError _$$_UserModelErrorFromJson(Map<String, dynamic> json) =>
    _$_UserModelError(
      json['message'] as String,
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UserModelErrorToJson(_$_UserModelError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'runtimeType': instance.$type,
    };

_$_UserModelLoading _$$_UserModelLoadingFromJson(Map<String, dynamic> json) =>
    _$_UserModelLoading(
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$$_UserModelLoadingToJson(_$_UserModelLoading instance) =>
    <String, dynamic>{
      'runtimeType': instance.$type,
    };
