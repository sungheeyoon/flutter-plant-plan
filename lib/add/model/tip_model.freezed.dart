// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tip_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TipModel _$TipModelFromJson(Map<String, dynamic> json) {
  return _TipModel.fromJson(json);
}

/// @nodoc
mixin _$TipModel {
  String get part => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get context => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TipModelCopyWith<TipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TipModelCopyWith<$Res> {
  factory $TipModelCopyWith(TipModel value, $Res Function(TipModel) then) =
      _$TipModelCopyWithImpl<$Res, TipModel>;
  @useResult
  $Res call({String part, String title, String context});
}

/// @nodoc
class _$TipModelCopyWithImpl<$Res, $Val extends TipModel>
    implements $TipModelCopyWith<$Res> {
  _$TipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? title = null,
    Object? context = null,
  }) {
    return _then(_value.copyWith(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TipModelCopyWith<$Res> implements $TipModelCopyWith<$Res> {
  factory _$$_TipModelCopyWith(
          _$_TipModel value, $Res Function(_$_TipModel) then) =
      __$$_TipModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String part, String title, String context});
}

/// @nodoc
class __$$_TipModelCopyWithImpl<$Res>
    extends _$TipModelCopyWithImpl<$Res, _$_TipModel>
    implements _$$_TipModelCopyWith<$Res> {
  __$$_TipModelCopyWithImpl(
      _$_TipModel _value, $Res Function(_$_TipModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? part = null,
    Object? title = null,
    Object? context = null,
  }) {
    return _then(_$_TipModel(
      part: null == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_TipModel implements _TipModel {
  _$_TipModel({this.part = '', this.title = '', this.context = ''});

  factory _$_TipModel.fromJson(Map<String, dynamic> json) =>
      _$$_TipModelFromJson(json);

  @override
  @JsonKey()
  final String part;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String context;

  @override
  String toString() {
    return 'TipModel(part: $part, title: $title, context: $context)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TipModel &&
            (identical(other.part, part) || other.part == part) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.context, context) || other.context == context));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, part, title, context);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TipModelCopyWith<_$_TipModel> get copyWith =>
      __$$_TipModelCopyWithImpl<_$_TipModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TipModelToJson(
      this,
    );
  }
}

abstract class _TipModel implements TipModel {
  factory _TipModel(
      {final String part,
      final String title,
      final String context}) = _$_TipModel;

  factory _TipModel.fromJson(Map<String, dynamic> json) = _$_TipModel.fromJson;

  @override
  String get part;
  @override
  String get title;
  @override
  String get context;
  @override
  @JsonKey(ignore: true)
  _$$_TipModelCopyWith<_$_TipModel> get copyWith =>
      throw _privateConstructorUsedError;
}
