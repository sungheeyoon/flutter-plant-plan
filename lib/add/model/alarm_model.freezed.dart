// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'alarm_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AlarmModel _$AlarmModelFromJson(Map<String, dynamic> json) {
  return _AlarmModel.fromJson(json);
}

/// @nodoc
mixin _$AlarmModel {
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
  $AlarmModelCopyWith<AlarmModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AlarmModelCopyWith<$Res> {
  factory $AlarmModelCopyWith(
          AlarmModel value, $Res Function(AlarmModel) then) =
      _$AlarmModelCopyWithImpl<$Res, AlarmModel>;
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
class _$AlarmModelCopyWithImpl<$Res, $Val extends AlarmModel>
    implements $AlarmModelCopyWith<$Res> {
  _$AlarmModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_AlarmModelCopyWith<$Res>
    implements $AlarmModelCopyWith<$Res> {
  factory _$$_AlarmModelCopyWith(
          _$_AlarmModel value, $Res Function(_$_AlarmModel) then) =
      __$$_AlarmModelCopyWithImpl<$Res>;
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
class __$$_AlarmModelCopyWithImpl<$Res>
    extends _$AlarmModelCopyWithImpl<$Res, _$_AlarmModel>
    implements _$$_AlarmModelCopyWith<$Res> {
  __$$_AlarmModelCopyWithImpl(
      _$_AlarmModel _value, $Res Function(_$_AlarmModel) _then)
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
    return _then(_$_AlarmModel(
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
class _$_AlarmModel implements _AlarmModel {
  _$_AlarmModel(
      {this.id = '',
      @TimestampSerializer() required this.startTime,
      this.repeat = 0,
      this.title = '',
      this.isOn = true,
      final List<DateTime> offDates = const [],
      required this.field})
      : _offDates = offDates;

  factory _$_AlarmModel.fromJson(Map<String, dynamic> json) =>
      _$$_AlarmModelFromJson(json);

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
    return 'AlarmModel(id: $id, startTime: $startTime, repeat: $repeat, title: $title, isOn: $isOn, offDates: $offDates, field: $field)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AlarmModel &&
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
  _$$_AlarmModelCopyWith<_$_AlarmModel> get copyWith =>
      __$$_AlarmModelCopyWithImpl<_$_AlarmModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AlarmModelToJson(
      this,
    );
  }
}

abstract class _AlarmModel implements AlarmModel {
  factory _AlarmModel(
      {final String id,
      @TimestampSerializer() required final DateTime startTime,
      final int repeat,
      final String title,
      final bool isOn,
      final List<DateTime> offDates,
      required final PlantField field}) = _$_AlarmModel;

  factory _AlarmModel.fromJson(Map<String, dynamic> json) =
      _$_AlarmModel.fromJson;

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
  _$$_AlarmModelCopyWith<_$_AlarmModel> get copyWith =>
      throw _privateConstructorUsedError;
}
