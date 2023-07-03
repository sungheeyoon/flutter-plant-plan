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
  PlantInformationKey get watering => throw _privateConstructorUsedError;
  PlantInformationKey get repotting => throw _privateConstructorUsedError;
  PlantInformationKey get nutrient => throw _privateConstructorUsedError;

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
      PlantInformationKey watering,
      PlantInformationKey repotting,
      PlantInformationKey nutrient});

  $PlantInformationKeyCopyWith<$Res> get watering;
  $PlantInformationKeyCopyWith<$Res> get repotting;
  $PlantInformationKeyCopyWith<$Res> get nutrient;
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
    Object? watering = null,
    Object? repotting = null,
    Object? nutrient = null,
  }) {
    return _then(_value.copyWith(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      watering: null == watering
          ? _value.watering
          : watering // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
      repotting: null == repotting
          ? _value.repotting
          : repotting // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlantInformationKeyCopyWith<$Res> get watering {
    return $PlantInformationKeyCopyWith<$Res>(_value.watering, (value) {
      return _then(_value.copyWith(watering: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlantInformationKeyCopyWith<$Res> get repotting {
    return $PlantInformationKeyCopyWith<$Res>(_value.repotting, (value) {
      return _then(_value.copyWith(repotting: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PlantInformationKeyCopyWith<$Res> get nutrient {
    return $PlantInformationKeyCopyWith<$Res>(_value.nutrient, (value) {
      return _then(_value.copyWith(nutrient: value) as $Val);
    });
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
      PlantInformationKey watering,
      PlantInformationKey repotting,
      PlantInformationKey nutrient});

  @override
  $PlantInformationKeyCopyWith<$Res> get watering;
  @override
  $PlantInformationKeyCopyWith<$Res> get repotting;
  @override
  $PlantInformationKeyCopyWith<$Res> get nutrient;
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
    Object? watering = null,
    Object? repotting = null,
    Object? nutrient = null,
  }) {
    return _then(_$_PlantInformationModel(
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      watering: null == watering
          ? _value.watering
          : watering // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
      repotting: null == repotting
          ? _value.repotting
          : repotting // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
      nutrient: null == nutrient
          ? _value.nutrient
          : nutrient // ignore: cast_nullable_to_non_nullable
              as PlantInformationKey,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlantInformationModel implements _PlantInformationModel {
  _$_PlantInformationModel(
      {this.alias = "",
      required this.watering,
      required this.repotting,
      required this.nutrient});

  factory _$_PlantInformationModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlantInformationModelFromJson(json);

  @override
  @JsonKey()
  final String alias;
  @override
  final PlantInformationKey watering;
  @override
  final PlantInformationKey repotting;
  @override
  final PlantInformationKey nutrient;

  @override
  String toString() {
    return 'PlantInformationModel(alias: $alias, watering: $watering, repotting: $repotting, nutrient: $nutrient)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlantInformationModel &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.watering, watering) ||
                other.watering == watering) &&
            (identical(other.repotting, repotting) ||
                other.repotting == repotting) &&
            (identical(other.nutrient, nutrient) ||
                other.nutrient == nutrient));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, alias, watering, repotting, nutrient);

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
      required final PlantInformationKey watering,
      required final PlantInformationKey repotting,
      required final PlantInformationKey nutrient}) = _$_PlantInformationModel;

  factory _PlantInformationModel.fromJson(Map<String, dynamic> json) =
      _$_PlantInformationModel.fromJson;

  @override
  String get alias;
  @override
  PlantInformationKey get watering;
  @override
  PlantInformationKey get repotting;
  @override
  PlantInformationKey get nutrient;
  @override
  @JsonKey(ignore: true)
  _$$_PlantInformationModelCopyWith<_$_PlantInformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

PlantInformationKey _$PlantInformationKeyFromJson(Map<String, dynamic> json) {
  return _PlantInformationKey.fromJson(json);
}

/// @nodoc
mixin _$PlantInformationKey {
  @TimestampSerializer()
  DateTime? get lastDay => throw _privateConstructorUsedError;
  Alarm get alarm => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlantInformationKeyCopyWith<PlantInformationKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantInformationKeyCopyWith<$Res> {
  factory $PlantInformationKeyCopyWith(
          PlantInformationKey value, $Res Function(PlantInformationKey) then) =
      _$PlantInformationKeyCopyWithImpl<$Res, PlantInformationKey>;
  @useResult
  $Res call({@TimestampSerializer() DateTime? lastDay, Alarm alarm});

  $AlarmCopyWith<$Res> get alarm;
}

/// @nodoc
class _$PlantInformationKeyCopyWithImpl<$Res, $Val extends PlantInformationKey>
    implements $PlantInformationKeyCopyWith<$Res> {
  _$PlantInformationKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastDay = freezed,
    Object? alarm = null,
  }) {
    return _then(_value.copyWith(
      lastDay: freezed == lastDay
          ? _value.lastDay
          : lastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      alarm: null == alarm
          ? _value.alarm
          : alarm // ignore: cast_nullable_to_non_nullable
              as Alarm,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AlarmCopyWith<$Res> get alarm {
    return $AlarmCopyWith<$Res>(_value.alarm, (value) {
      return _then(_value.copyWith(alarm: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlantInformationKeyCopyWith<$Res>
    implements $PlantInformationKeyCopyWith<$Res> {
  factory _$$_PlantInformationKeyCopyWith(_$_PlantInformationKey value,
          $Res Function(_$_PlantInformationKey) then) =
      __$$_PlantInformationKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@TimestampSerializer() DateTime? lastDay, Alarm alarm});

  @override
  $AlarmCopyWith<$Res> get alarm;
}

/// @nodoc
class __$$_PlantInformationKeyCopyWithImpl<$Res>
    extends _$PlantInformationKeyCopyWithImpl<$Res, _$_PlantInformationKey>
    implements _$$_PlantInformationKeyCopyWith<$Res> {
  __$$_PlantInformationKeyCopyWithImpl(_$_PlantInformationKey _value,
      $Res Function(_$_PlantInformationKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastDay = freezed,
    Object? alarm = null,
  }) {
    return _then(_$_PlantInformationKey(
      lastDay: freezed == lastDay
          ? _value.lastDay
          : lastDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      alarm: null == alarm
          ? _value.alarm
          : alarm // ignore: cast_nullable_to_non_nullable
              as Alarm,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlantInformationKey implements _PlantInformationKey {
  _$_PlantInformationKey(
      {@TimestampSerializer() this.lastDay = null, required this.alarm});

  factory _$_PlantInformationKey.fromJson(Map<String, dynamic> json) =>
      _$$_PlantInformationKeyFromJson(json);

  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? lastDay;
  @override
  final Alarm alarm;

  @override
  String toString() {
    return 'PlantInformationKey(lastDay: $lastDay, alarm: $alarm)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlantInformationKey &&
            (identical(other.lastDay, lastDay) || other.lastDay == lastDay) &&
            (identical(other.alarm, alarm) || other.alarm == alarm));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lastDay, alarm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlantInformationKeyCopyWith<_$_PlantInformationKey> get copyWith =>
      __$$_PlantInformationKeyCopyWithImpl<_$_PlantInformationKey>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlantInformationKeyToJson(
      this,
    );
  }
}

abstract class _PlantInformationKey implements PlantInformationKey {
  factory _PlantInformationKey(
      {@TimestampSerializer() final DateTime? lastDay,
      required final Alarm alarm}) = _$_PlantInformationKey;

  factory _PlantInformationKey.fromJson(Map<String, dynamic> json) =
      _$_PlantInformationKey.fromJson;

  @override
  @TimestampSerializer()
  DateTime? get lastDay;
  @override
  Alarm get alarm;
  @override
  @JsonKey(ignore: true)
  _$$_PlantInformationKeyCopyWith<_$_PlantInformationKey> get copyWith =>
      throw _privateConstructorUsedError;
}

Alarm _$AlarmFromJson(Map<String, dynamic> json) {
  return _Alarm.fromJson(json);
}

/// @nodoc
mixin _$Alarm {
  String get id => throw _privateConstructorUsedError; // ID 필드 추가
  @TimestampSerializer()
  DateTime get startTime => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get startDay => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get nextAlarm => throw _privateConstructorUsedError;
  int get repeat => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get isOn => throw _privateConstructorUsedError;
  List<DateTime> get offDates => throw _privateConstructorUsedError;

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
      @TimestampSerializer() DateTime? startDay,
      @TimestampSerializer() DateTime? nextAlarm,
      int repeat,
      String title,
      bool isOn,
      List<DateTime> offDates});
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
    Object? startDay = freezed,
    Object? nextAlarm = freezed,
    Object? repeat = null,
    Object? title = null,
    Object? isOn = null,
    Object? offDates = null,
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
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextAlarm: freezed == nextAlarm
          ? _value.nextAlarm
          : nextAlarm // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
      @TimestampSerializer() DateTime? startDay,
      @TimestampSerializer() DateTime? nextAlarm,
      int repeat,
      String title,
      bool isOn,
      List<DateTime> offDates});
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
    Object? startDay = freezed,
    Object? nextAlarm = freezed,
    Object? repeat = null,
    Object? title = null,
    Object? isOn = null,
    Object? offDates = null,
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
      startDay: freezed == startDay
          ? _value.startDay
          : startDay // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      nextAlarm: freezed == nextAlarm
          ? _value.nextAlarm
          : nextAlarm // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Alarm implements _Alarm {
  _$_Alarm(
      {this.id = '',
      @TimestampSerializer() required this.startTime,
      @TimestampSerializer() this.startDay = null,
      @TimestampSerializer() this.nextAlarm = null,
      this.repeat = 0,
      this.title = '',
      this.isOn = true,
      final List<DateTime> offDates = const []})
      : _offDates = offDates;

  factory _$_Alarm.fromJson(Map<String, dynamic> json) =>
      _$$_AlarmFromJson(json);

  @override
  @JsonKey()
  final String id;
// ID 필드 추가
  @override
  @TimestampSerializer()
  final DateTime startTime;
  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? startDay;
  @override
  @JsonKey()
  @TimestampSerializer()
  final DateTime? nextAlarm;
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
  String toString() {
    return 'Alarm(id: $id, startTime: $startTime, startDay: $startDay, nextAlarm: $nextAlarm, repeat: $repeat, title: $title, isOn: $isOn, offDates: $offDates)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Alarm &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.startDay, startDay) ||
                other.startDay == startDay) &&
            (identical(other.nextAlarm, nextAlarm) ||
                other.nextAlarm == nextAlarm) &&
            (identical(other.repeat, repeat) || other.repeat == repeat) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.isOn, isOn) || other.isOn == isOn) &&
            const DeepCollectionEquality().equals(other._offDates, _offDates));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      startTime,
      startDay,
      nextAlarm,
      repeat,
      title,
      isOn,
      const DeepCollectionEquality().hash(_offDates));

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
      @TimestampSerializer() final DateTime? startDay,
      @TimestampSerializer() final DateTime? nextAlarm,
      final int repeat,
      final String title,
      final bool isOn,
      final List<DateTime> offDates}) = _$_Alarm;

  factory _Alarm.fromJson(Map<String, dynamic> json) = _$_Alarm.fromJson;

  @override
  String get id;
  @override // ID 필드 추가
  @TimestampSerializer()
  DateTime get startTime;
  @override
  @TimestampSerializer()
  DateTime? get startDay;
  @override
  @TimestampSerializer()
  DateTime? get nextAlarm;
  @override
  int get repeat;
  @override
  String get title;
  @override
  bool get isOn;
  @override
  List<DateTime> get offDates;
  @override
  @JsonKey(ignore: true)
  _$$_AlarmCopyWith<_$_Alarm> get copyWith =>
      throw _privateConstructorUsedError;
}
