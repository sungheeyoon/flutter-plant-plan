// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlantInformationModel _$PlantInformationModelFromJson(
    Map<String, dynamic> json) {
  return _PlantInformationModel.fromJson(json);
}

/// @nodoc
mixin _$PlantInformationModel {
  String get alias => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get watringLastDay => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get repottingLastDay => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get nutrientLastDay => throw _privateConstructorUsedError;
  List<Alarm> get alarms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlantInformationModelCopyWith<PlantInformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantInformationModelCopyWith<$Res> {
  factory $PlantInformationModelCopyWith(PlantInformationModel value,
          $Res Function(PlantInformationModel) then) =
      _$PlantInformationModelCopyWithImpl<$Res, PlantInformationModel>;
  @useResult
  $Res call(
      {String alias,
      @TimestampSerializer() DateTime? watringLastDay,
      @TimestampSerializer() DateTime? repottingLastDay,
      @TimestampSerializer() DateTime? nutrientLastDay,
      List<Alarm> alarms});
}

/// @nodoc
class _$PlantInformationModelCopyWithImpl<$Res,
        $Val extends PlantInformationModel>
    implements $PlantInformationModelCopyWith<$Res> {
  _$PlantInformationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? watringLastDay = freezed,
    Object? repottingLastDay = freezed,
    Object? nutrientLastDay = freezed,
    Object? alarms = null,
  }) {
    return _then(_value.copyWith(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      watringLastDay: freezed == watringLastDay
          ? _value.watringLastDay
          : watringLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repottingLastDay: freezed == repottingLastDay
          ? _value.repottingLastDay
          : repottingLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nutrientLastDay: freezed == nutrientLastDay
          ? _value.nutrientLastDay
          : nutrientLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      alarms: null == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<Alarm>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PlantInformationModelCopyWith<$Res>
    implements $PlantInformationModelCopyWith<$Res> {
  factory _$$_PlantInformationModelCopyWith(_$_PlantInformationModel value,
          $Res Function(_$_PlantInformationModel) then) =
      __$$_PlantInformationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String alias,
      @TimestampSerializer() DateTime? watringLastDay,
      @TimestampSerializer() DateTime? repottingLastDay,
      @TimestampSerializer() DateTime? nutrientLastDay,
      List<Alarm> alarms});
}

/// @nodoc
class __$$_PlantInformationModelCopyWithImpl<$Res>
    extends _$PlantInformationModelCopyWithImpl<$Res, _$_PlantInformationModel>
    implements _$$_PlantInformationModelCopyWith<$Res> {
  __$$_PlantInformationModelCopyWithImpl(_$_PlantInformationModel _value,
      $Res Function(_$_PlantInformationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? alias = null,
    Object? watringLastDay = freezed,
    Object? repottingLastDay = freezed,
    Object? nutrientLastDay = freezed,
    Object? alarms = null,
  }) {
    return _then(_$_PlantInformationModel(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      watringLastDay: freezed == watringLastDay
          ? _value.watringLastDay
          : watringLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      repottingLastDay: freezed == repottingLastDay
          ? _value.repottingLastDay
          : repottingLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nutrientLastDay: freezed == nutrientLastDay
          ? _value.nutrientLastDay
          : nutrientLastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      alarms: null == alarms
          ? _value._alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<Alarm>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlantInformationModel implements _PlantInformationModel {
  _$_PlantInformationModel(
      {this.alias = "",
      @TimestampSerializer() this.watringLastDay = null,
      @TimestampSerializer() this.repottingLastDay = null,
      @TimestampSerializer() this.nutrientLastDay = null,
      final List<Alarm> alarms = const []})
      : _alarms = alarms;

  factory _$_PlantInformationModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlantInformationModelFromJson(json);

  @override
  @JsonKey()
  final String alias;
  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? watringLastDay;
  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? repottingLastDay;
  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? nutrientLastDay;
  final List<Alarm> _alarms;
  @override
  @JsonKey()
  List<Alarm> get alarms {
    if (_alarms is EqualUnmodifiableListView) return _alarms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarms);
  }

  @override
  String toString() {
    return 'PlantInformationModel(alias: $alias, watringLastDay: $watringLastDay, repottingLastDay: $repottingLastDay, nutrientLastDay: $nutrientLastDay, alarms: $alarms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlantInformationModel &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.watringLastDay, watringLastDay) ||
                other.watringLastDay == watringLastDay) &&
            (identical(other.repottingLastDay, repottingLastDay) ||
                other.repottingLastDay == repottingLastDay) &&
            (identical(other.nutrientLastDay, nutrientLastDay) ||
                other.nutrientLastDay == nutrientLastDay) &&
            const DeepCollectionEquality().equals(other._alarms, _alarms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      alias,
      watringLastDay,
      repottingLastDay,
      nutrientLastDay,
      const DeepCollectionEquality().hash(_alarms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlantInformationModelCopyWith<_$_PlantInformationModel> get copyWith =>
      __$$_PlantInformationModelCopyWithImpl<_$_PlantInformationModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlantInformationModelToJson(
      this,
    );
  }
}

abstract class _PlantInformationModel implements PlantInformationModel {
  factory _PlantInformationModel(
      {final String alias,
      @TimestampSerializer() final DateTime? watringLastDay,
      @TimestampSerializer() final DateTime? repottingLastDay,
      @TimestampSerializer() final DateTime? nutrientLastDay,
      final List<Alarm> alarms}) = _$_PlantInformationModel;

  factory _PlantInformationModel.fromJson(Map<String, dynamic> json) =
      _$_PlantInformationModel.fromJson;

  @override
  String get alias;
  @override
  @TimestampSerializer()
  DateTime? get watringLastDay;
  @override
  @TimestampSerializer()
  DateTime? get repottingLastDay;
  @override
  @TimestampSerializer()
  DateTime? get nutrientLastDay;
  @override
  List<Alarm> get alarms;
  @override
  @JsonKey(ignore: true)
  _$$_PlantInformationModelCopyWith<_$_PlantInformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  String get id => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get startTime => throw _privateConstructorUsedError;
  int get repeat => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isOn => throw _privateConstructorUsedError;
  List<DateTime> get offDates => throw _privateConstructorUsedError;
  PlantField get field => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AlarmCopyWith<Alarm> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmCopyWith<$Res> {
  factory $AlarmCopyWith(Alarm value, $Res Function(Alarm) then) =
      _$AlarmCopyWithImpl<$Res, Alarm>;
  @useResult
  $Res call(
      {String id,
      @TimestampSerializer() DateTime startTime,
      int repeat,
      String title,
      bool isOn,
      List<DateTime> offDates,
      PlantField field});
}

/// @nodoc
class _$AlarmCopyWithImpl<$Res, $Val extends Alarm>
    implements $AlarmCopyWith<$Res> {
  _$AlarmCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTime = null,
    Object? repeat = null,
    Object? title = null,
    Object? isOn = null,
    Object? offDates = null,
    Object? field = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isOn: null == isOn
          ? _value.isOn
          : isOn // ignore: cast_nullable_to_non_nullable
              as bool,
      offDates: null == offDates
          ? _value.offDates
          : offDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as PlantField,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AlarmCopyWith<$Res> implements $AlarmCopyWith<$Res> {
  factory _$$_AlarmCopyWith(_$_Alarm value, $Res Function(_$_Alarm) then) =
      __$$_AlarmCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @TimestampSerializer() DateTime startTime,
      int repeat,
      String title,
      bool isOn,
      List<DateTime> offDates,
      PlantField field});
}

/// @nodoc
class __$$_AlarmCopyWithImpl<$Res> extends _$AlarmCopyWithImpl<$Res, _$_Alarm>
    implements _$$_AlarmCopyWith<$Res> {
  __$$_AlarmCopyWithImpl(_$_Alarm _value, $Res Function(_$_Alarm) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? startTime = null,
    Object? repeat = null,
    Object? title = null,
    Object? isOn = null,
    Object? offDates = null,
    Object? field = null,
  }) {
    return _then(_$_Alarm(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      repeat: null == repeat
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      isOn: null == isOn
          ? _value.isOn
          : isOn // ignore: cast_nullable_to_non_nullable
              as bool,
      offDates: null == offDates
          ? _value._offDates
          : offDates // ignore: cast_nullable_to_non_nullable
              as List<DateTime>,
      field: null == field
          ? _value.field
          : field // ignore: cast_nullable_to_non_nullable
              as PlantField,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Alarm implements _Alarm {
  _$_Alarm(
      {this.id = '',
      @TimestampSerializer() required this.startTime,
      this.repeat = 0,
      this.title = '',
      this.isOn = false,
      final List<DateTime> offDates = const [],
      required this.field})
      : _offDates = offDates;

  factory _$_Alarm.fromJson(Map<String, dynamic> json) =>
      _$$_AlarmFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @TimestampSerializer()
  final DateTime startTime;
  @override
  @JsonKey()
  final int repeat;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final bool isOn;
  final List<DateTime> _offDates;
  @override
  @JsonKey()
  List<DateTime> get offDates {
    if (_offDates is EqualUnmodifiableListView) return _offDates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_offDates);
  }

  @override
  final PlantField field;

  @override
  String toString() {
    return 'Alarm(id: $id, startTime: $startTime, repeat: $repeat, title: $title, isOn: $isOn, offDates: $offDates, field: $field)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alarm &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isOn, isOn) || other.isOn == isOn) &&
            const DeepCollectionEquality().equals(other._offDates, _offDates) &&
            (identical(other.field, field) || other.field == field));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, startTime, repeat, title,
      isOn, const DeepCollectionEquality().hash(_offDates), field);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      __$$_AlarmCopyWithImpl<_$_Alarm>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlarmToJson(
      this,
    );
  }
}

abstract class _Alarm implements Alarm {
  factory _Alarm(
      {final String id,
      @TimestampSerializer() required final DateTime startTime,
      final int repeat,
      final String title,
      final bool isOn,
      final List<DateTime> offDates,
      required final PlantField field}) = _$_Alarm;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$_Alarm.fromJson;

  @override
  String get id;
  @override
  @TimestampSerializer()
  DateTime get startTime;
  @override
  int get repeat;
  @override
  String get title;
  @override
  bool get isOn;
  @override
  List<DateTime> get offDates;
  @override
  PlantField get field;
  @override
  @JsonKey(ignore: true)
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      throw _privateConstructorUsedError;
}
