import 'package:plant_plan/add/model/plant_model.dart';

import 'package:json_annotation/json_annotation.dart';

part 'cursor_pagination_model.g.dart';

abstract class CursorPaginationBase {}

class CursorPaginationError extends CursorPaginationBase {
  final String message;

  CursorPaginationError({
    required this.message,
  });
}

class CursorPaginationLoading extends CursorPaginationBase {}

@JsonSerializable()
class CursorPagination extends CursorPaginationBase {
  final List<PlantModel> data;

  CursorPagination({
    required this.data,
  });

  CursorPagination copyWith({
    List<PlantModel>? data,
  }) {
    return CursorPagination(
      data: data ?? this.data,
    );
  }

  factory CursorPagination.fromJson(Map<String, dynamic> json) =>
      _$CursorPaginationFromJson(json);
}

//새로고침 할때
class CursorPaginationRefetching extends CursorPagination {
  CursorPaginationRefetching({
    required super.data,
  });
}

//리스트의 맨 아래로 내려서
//추가 데이터를 요청하는중
class CursorPaginationFethcingMore extends CursorPagination {
  CursorPaginationFethcingMore({
    required super.data,
  });
}
