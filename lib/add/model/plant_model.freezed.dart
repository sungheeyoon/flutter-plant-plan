// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PlantModel _$PlantModelFromJson(Map<String, dynamic> json) {
  return _PlantModel.fromJson(json);
}

/// @nodoc
mixin _$PlantModel {
  String get docId => throw _privateConstructorUsedError;
  String get userImageUrl => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  bool get favorite => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get watringLastDay => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get repottingLastDay => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime? get nutrientLastDay => throw _privateConstructorUsedError;
  InformationModel get information => throw _privateConstructorUsedError;
  List<DiaryModel> get diary => throw _privateConstructorUsedError;
  List<AlarmModel> get alarms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PlantModelCopyWith<PlantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlantModelCopyWith<$Res> {
  factory $PlantModelCopyWith(
          PlantModel value, $Res Function(PlantModel) then) =
      _$PlantModelCopyWithImpl<$Res, PlantModel>;
  @useResult
  $Res call(
      {String docId,
      String userImageUrl,
      String alias,
      bool favorite,
      @TimestampSerializer() DateTime? watringLastDay,
      @TimestampSerializer() DateTime? repottingLastDay,
      @TimestampSerializer() DateTime? nutrientLastDay,
      InformationModel information,
      List<DiaryModel> diary,
      List<AlarmModel> alarms});

  $InformationModelCopyWith<$Res> get information;
}

/// @nodoc
class _$PlantModelCopyWithImpl<$Res, $Val extends PlantModel>
    implements $PlantModelCopyWith<$Res> {
  _$PlantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? userImageUrl = null,
    Object? alias = null,
    Object? favorite = null,
    Object? watringLastDay = freezed,
    Object? repottingLastDay = freezed,
    Object? nutrientLastDay = freezed,
    Object? information = null,
    Object? diary = null,
    Object? alarms = null,
  }) {
    return _then(_value.copyWith(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: null == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
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
      information: null == information
          ? _value.information
          : information // ignore: cast_nullable_to_non_nullable
              as InformationModel,
      diary: null == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as List<DiaryModel>,
      alarms: null == alarms
          ? _value.alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmModel>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InformationModelCopyWith<$Res> get information {
    return $InformationModelCopyWith<$Res>(_value.information, (value) {
      return _then(_value.copyWith(information: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PlantModelCopyWith<$Res>
    implements $PlantModelCopyWith<$Res> {
  factory _$$_PlantModelCopyWith(
          _$_PlantModel value, $Res Function(_$_PlantModel) then) =
      __$$_PlantModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docId,
      String userImageUrl,
      String alias,
      bool favorite,
      @TimestampSerializer() DateTime? watringLastDay,
      @TimestampSerializer() DateTime? repottingLastDay,
      @TimestampSerializer() DateTime? nutrientLastDay,
      InformationModel information,
      List<DiaryModel> diary,
      List<AlarmModel> alarms});

  @override
  $InformationModelCopyWith<$Res> get information;
}

/// @nodoc
class __$$_PlantModelCopyWithImpl<$Res>
    extends _$PlantModelCopyWithImpl<$Res, _$_PlantModel>
    implements _$$_PlantModelCopyWith<$Res> {
  __$$_PlantModelCopyWithImpl(
      _$_PlantModel _value, $Res Function(_$_PlantModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? userImageUrl = null,
    Object? alias = null,
    Object? favorite = null,
    Object? watringLastDay = freezed,
    Object? repottingLastDay = freezed,
    Object? nutrientLastDay = freezed,
    Object? information = null,
    Object? diary = null,
    Object? alarms = null,
  }) {
    return _then(_$_PlantModel(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      userImageUrl: null == userImageUrl
          ? _value.userImageUrl
          : userImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      favorite: null == favorite
          ? _value.favorite
          : favorite // ignore: cast_nullable_to_non_nullable
              as bool,
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
      information: null == information
          ? _value.information
          : information // ignore: cast_nullable_to_non_nullable
              as InformationModel,
      diary: null == diary
          ? _value._diary
          : diary // ignore: cast_nullable_to_non_nullable
              as List<DiaryModel>,
      alarms: null == alarms
          ? _value._alarms
          : alarms // ignore: cast_nullable_to_non_nullable
              as List<AlarmModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PlantModel implements _PlantModel {
  _$_PlantModel(
      {this.docId = "",
      this.userImageUrl = "",
      this.alias = "",
      this.favorite = false,
      @TimestampSerializer() this.watringLastDay = null,
      @TimestampSerializer() this.repottingLastDay = null,
      @TimestampSerializer() this.nutrientLastDay = null,
      required this.information,
      final List<DiaryModel> diary = const [],
      final List<AlarmModel> alarms = const []})
      : _diary = diary,
        _alarms = alarms;

  factory _$_PlantModel.fromJson(Map<String, dynamic> json) =>
      _$$_PlantModelFromJson(json);

  @override
  @JsonKey()
  final String docId;
  @override
  @JsonKey()
  final String userImageUrl;
  @override
  @JsonKey()
  final String alias;
  @override
  @JsonKey()
  final bool favorite;
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
  @override
  final InformationModel information;
  final List<DiaryModel> _diary;
  @override
  @JsonKey()
  List<DiaryModel> get diary {
    if (_diary is EqualUnmodifiableListView) return _diary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_diary);
  }

  final List<AlarmModel> _alarms;
  @override
  @JsonKey()
  List<AlarmModel> get alarms {
    if (_alarms is EqualUnmodifiableListView) return _alarms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_alarms);
  }

  @override
  String toString() {
    return 'PlantModel(docId: $docId, userImageUrl: $userImageUrl, alias: $alias, favorite: $favorite, watringLastDay: $watringLastDay, repottingLastDay: $repottingLastDay, nutrientLastDay: $nutrientLastDay, information: $information, diary: $diary, alarms: $alarms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PlantModel &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.userImageUrl, userImageUrl) ||
                other.userImageUrl == userImageUrl) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.favorite, favorite) ||
                other.favorite == favorite) &&
            (identical(other.watringLastDay, watringLastDay) ||
                other.watringLastDay == watringLastDay) &&
            (identical(other.repottingLastDay, repottingLastDay) ||
                other.repottingLastDay == repottingLastDay) &&
            (identical(other.nutrientLastDay, nutrientLastDay) ||
                other.nutrientLastDay == nutrientLastDay) &&
            (identical(other.information, information) ||
                other.information == information) &&
            const DeepCollectionEquality().equals(other._diary, _diary) &&
            const DeepCollectionEquality().equals(other._alarms, _alarms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      docId,
      userImageUrl,
      alias,
      favorite,
      watringLastDay,
      repottingLastDay,
      nutrientLastDay,
      information,
      const DeepCollectionEquality().hash(_diary),
      const DeepCollectionEquality().hash(_alarms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PlantModelCopyWith<_$_PlantModel> get copyWith =>
      __$$_PlantModelCopyWithImpl<_$_PlantModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PlantModelToJson(
      this,
    );
  }
}

abstract class _PlantModel implements PlantModel {
  factory _PlantModel(
      {final String docId,
      final String userImageUrl,
      final String alias,
      final bool favorite,
      @TimestampSerializer() final DateTime? watringLastDay,
      @TimestampSerializer() final DateTime? repottingLastDay,
      @TimestampSerializer() final DateTime? nutrientLastDay,
      required final InformationModel information,
      final List<DiaryModel> diary,
      final List<AlarmModel> alarms}) = _$_PlantModel;

  factory _PlantModel.fromJson(Map<String, dynamic> json) =
      _$_PlantModel.fromJson;

  @override
  String get docId;
  @override
  String get userImageUrl;
  @override
  String get alias;
  @override
  bool get favorite;
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
  InformationModel get information;
  @override
  List<DiaryModel> get diary;
  @override
  List<AlarmModel> get alarms;
  @override
  @JsonKey(ignore: true)
  _$$_PlantModelCopyWith<_$_PlantModel> get copyWith =>
      throw _privateConstructorUsedError;
}
