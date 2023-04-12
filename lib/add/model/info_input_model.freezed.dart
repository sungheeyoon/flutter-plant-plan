// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'info_input_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InfoInputModel _$InfoInputModelFromJson(Map<String, dynamic> json) {
  return _InfoInputModel.fromJson(json);
}

/// @nodoc
mixin _$InfoInputModel {
  String get alias => throw _privateConstructorUsedError;
  String get wateringDay => throw _privateConstructorUsedError;
  String get divisionDay => throw _privateConstructorUsedError;
  String get nutrientDay => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InfoInputModelCopyWith<InfoInputModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InfoInputModelCopyWith<$Res> {
  factory $InfoInputModelCopyWith(
          InfoInputModel value, $Res Function(InfoInputModel) then) =
      _$InfoInputModelCopyWithImpl<$Res, InfoInputModel>;
  @useResult
  $Res call(
      {String alias,
      String wateringDay,
      String divisionDay,
      String nutrientDay});
}

/// @nodoc
class _$InfoInputModelCopyWithImpl<$Res, $Val extends InfoInputModel>
    implements $InfoInputModelCopyWith<$Res> {
  _$InfoInputModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? wateringDay = null,
    Object? divisionDay = null,
    Object? nutrientDay = null,
  }) {
    return _then(_value.copyWith(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      wateringDay: null == wateringDay
          ? _value.wateringDay
          : wateringDay // ignore: cast_nullable_to_non_nullable
              as String,
      divisionDay: null == divisionDay
          ? _value.divisionDay
          : divisionDay // ignore: cast_nullable_to_non_nullable
              as String,
      nutrientDay: null == nutrientDay
          ? _value.nutrientDay
          : nutrientDay // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InfoInputModelCopyWith<$Res>
    implements $InfoInputModelCopyWith<$Res> {
  factory _$$_InfoInputModelCopyWith(
          _$_InfoInputModel value, $Res Function(_$_InfoInputModel) then) =
      __$$_InfoInputModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String alias,
      String wateringDay,
      String divisionDay,
      String nutrientDay});
}

/// @nodoc
class __$$_InfoInputModelCopyWithImpl<$Res>
    extends _$InfoInputModelCopyWithImpl<$Res, _$_InfoInputModel>
    implements _$$_InfoInputModelCopyWith<$Res> {
  __$$_InfoInputModelCopyWithImpl(
      _$_InfoInputModel _value, $Res Function(_$_InfoInputModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? wateringDay = null,
    Object? divisionDay = null,
    Object? nutrientDay = null,
  }) {
    return _then(_$_InfoInputModel(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      wateringDay: null == wateringDay
          ? _value.wateringDay
          : wateringDay // ignore: cast_nullable_to_non_nullable
              as String,
      divisionDay: null == divisionDay
          ? _value.divisionDay
          : divisionDay // ignore: cast_nullable_to_non_nullable
              as String,
      nutrientDay: null == nutrientDay
          ? _value.nutrientDay
          : nutrientDay // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InfoInputModel implements _InfoInputModel {
  const _$_InfoInputModel(
      {this.alias = "",
      this.wateringDay = "",
      this.divisionDay = "",
      this.nutrientDay = ""});

  factory _$_InfoInputModel.fromJson(Map<String, dynamic> json) =>
      _$$_InfoInputModelFromJson(json);

  @override
  @JsonKey()
  final String alias;
  @override
  @JsonKey()
  final String wateringDay;
  @override
  @JsonKey()
  final String divisionDay;
  @override
  @JsonKey()
  final String nutrientDay;

  @override
  String toString() {
    return 'InfoInputModel(alias: $alias, wateringDay: $wateringDay, divisionDay: $divisionDay, nutrientDay: $nutrientDay)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InfoInputModel &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.wateringDay, wateringDay) ||
                other.wateringDay == wateringDay) &&
            (identical(other.divisionDay, divisionDay) ||
                other.divisionDay == divisionDay) &&
            (identical(other.nutrientDay, nutrientDay) ||
                other.nutrientDay == nutrientDay));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, alias, wateringDay, divisionDay, nutrientDay);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InfoInputModelCopyWith<_$_InfoInputModel> get copyWith =>
      __$$_InfoInputModelCopyWithImpl<_$_InfoInputModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InfoInputModelToJson(
      this,
    );
  }
}

abstract class _InfoInputModel implements InfoInputModel {
  const factory _InfoInputModel(
      {final String alias,
      final String wateringDay,
      final String divisionDay,
      final String nutrientDay}) = _$_InfoInputModel;

  factory _InfoInputModel.fromJson(Map<String, dynamic> json) =
      _$_InfoInputModel.fromJson;

  @override
  String get alias;
  @override
  String get wateringDay;
  @override
  String get divisionDay;
  @override
  String get nutrientDay;
  @override
  @JsonKey(ignore: true)
  _$$_InfoInputModelCopyWith<_$_InfoInputModel> get copyWith =>
      throw _privateConstructorUsedError;
}
