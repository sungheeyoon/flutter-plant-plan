// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AnnouncementModel _$$_AnnouncementModelFromJson(Map<String, dynamic> json) =>
    _$_AnnouncementModel(
      title: json['title'] as String,
      date: const TimestampSerializer().fromJson(json['date']),
      isNew: json['isNew'] as bool,
      body: json['body'] as String,
      isExpanded: json['isExpanded'] as bool? ?? false,
    );

Map<String, dynamic> _$$_AnnouncementModelToJson(
        _$_AnnouncementModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'date': const TimestampSerializer().toJson(instance.date),
      'isNew': instance.isNew,
      'body': instance.body,
      'isExpanded': instance.isExpanded,
    };
