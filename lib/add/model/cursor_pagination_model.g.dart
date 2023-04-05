// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cursor_pagination_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CursorPagination _$CursorPaginationFromJson(Map<String, dynamic> json) =>
    CursorPagination(
      data: (json['data'] as List<dynamic>)
          .map((e) => PlantModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CursorPaginationToJson(CursorPagination instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
