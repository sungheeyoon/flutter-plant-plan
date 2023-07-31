// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DiaryModel _$$_DiaryModelFromJson(Map<String, dynamic> json) =>
    _$_DiaryModel(
      id: json['id'] as String? ?? '',
      date: const TimestampSerializer().fromJson(json['date']),
      emoji: json['emoji'] as String? ?? '',
      title: json['title'] as String? ?? '',
      imageUrl: (json['imageUrl'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      context: json['context'] as String? ?? '',
      bookMark: json['bookMark'] as bool? ?? false,
    );

Map<String, dynamic> _$$_DiaryModelToJson(_$_DiaryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': const TimestampSerializer().toJson(instance.date),
      'emoji': instance.emoji,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'context': instance.context,
      'bookMark': instance.bookMark,
    };
