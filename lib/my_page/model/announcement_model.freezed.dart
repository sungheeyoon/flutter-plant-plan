// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'announcement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AnnouncementModel _$AnnouncementModelFromJson(Map<String, dynamic> json) {
  return _AnnouncementModel.fromJson(json);
}

/// @nodoc
mixin _$AnnouncementModel {
  String get title => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get date => throw _privateConstructorUsedError;
  bool get isNew => throw _privateConstructorUsedError;
  String get body => throw _privateConstructorUsedError;
  bool get isExpanded => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AnnouncementModelCopyWith<AnnouncementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnnouncementModelCopyWith<$Res> {
  factory $AnnouncementModelCopyWith(
          AnnouncementModel value, $Res Function(AnnouncementModel) then) =
      _$AnnouncementModelCopyWithImpl<$Res, AnnouncementModel>;
  @useResult
  $Res call(
      {String title,
      @TimestampSerializer() DateTime date,
      bool isNew,
      String body,
      bool isExpanded});
}

/// @nodoc
class _$AnnouncementModelCopyWithImpl<$Res, $Val extends AnnouncementModel>
    implements $AnnouncementModelCopyWith<$Res> {
  _$AnnouncementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? date = null,
    Object? isNew = null,
    Object? body = null,
    Object? isExpanded = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AnnouncementModelCopyWith<$Res>
    implements $AnnouncementModelCopyWith<$Res> {
  factory _$$_AnnouncementModelCopyWith(_$_AnnouncementModel value,
          $Res Function(_$_AnnouncementModel) then) =
      __$$_AnnouncementModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      @TimestampSerializer() DateTime date,
      bool isNew,
      String body,
      bool isExpanded});
}

/// @nodoc
class __$$_AnnouncementModelCopyWithImpl<$Res>
    extends _$AnnouncementModelCopyWithImpl<$Res, _$_AnnouncementModel>
    implements _$$_AnnouncementModelCopyWith<$Res> {
  __$$_AnnouncementModelCopyWithImpl(
      _$_AnnouncementModel _value, $Res Function(_$_AnnouncementModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? date = null,
    Object? isNew = null,
    Object? body = null,
    Object? isExpanded = null,
  }) {
    return _then(_$_AnnouncementModel(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isNew: null == isNew
          ? _value.isNew
          : isNew // ignore: cast_nullable_to_non_nullable
              as bool,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      isExpanded: null == isExpanded
          ? _value.isExpanded
          : isExpanded // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AnnouncementModel implements _AnnouncementModel {
  _$_AnnouncementModel(
      {required this.title,
      @TimestampSerializer() required this.date,
      required this.isNew,
      required this.body,
      this.isExpanded = false});

  factory _$_AnnouncementModel.fromJson(Map<String, dynamic> json) =>
      _$$_AnnouncementModelFromJson(json);

  @override
  final String title;
  @override
  @TimestampSerializer()
  final DateTime date;
  @override
  final bool isNew;
  @override
  final String body;
  @override
  @JsonKey()
  final bool isExpanded;

  @override
  String toString() {
    return 'AnnouncementModel(title: $title, date: $date, isNew: $isNew, body: $body, isExpanded: $isExpanded)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AnnouncementModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.isNew, isNew) || other.isNew == isNew) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.isExpanded, isExpanded) ||
                other.isExpanded == isExpanded));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, date, isNew, body, isExpanded);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AnnouncementModelCopyWith<_$_AnnouncementModel> get copyWith =>
      __$$_AnnouncementModelCopyWithImpl<_$_AnnouncementModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AnnouncementModelToJson(
      this,
    );
  }
}

abstract class _AnnouncementModel implements AnnouncementModel {
  factory _AnnouncementModel(
      {required final String title,
      @TimestampSerializer() required final DateTime date,
      required final bool isNew,
      required final String body,
      final bool isExpanded}) = _$_AnnouncementModel;

  factory _AnnouncementModel.fromJson(Map<String, dynamic> json) =
      _$_AnnouncementModel.fromJson;

  @override
  String get title;
  @override
  @TimestampSerializer()
  DateTime get date;
  @override
  bool get isNew;
  @override
  String get body;
  @override
  bool get isExpanded;
  @override
  @JsonKey(ignore: true)
  _$$_AnnouncementModelCopyWith<_$_AnnouncementModel> get copyWith =>
      throw _privateConstructorUsedError;
}
