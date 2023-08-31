// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryCardModel _$DiaryCardModelFromJson(Map<String, dynamic> json) {
  return _DiaryCardModel.fromJson(json);
}

/// @nodoc
mixin _$DiaryCardModel {
  String get docId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get alias => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  DiaryModel get diary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryCardModelCopyWith<DiaryCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryCardModelCopyWith<$Res> {
  factory $DiaryCardModelCopyWith(
          DiaryCardModel value, $Res Function(DiaryCardModel) then) =
      _$DiaryCardModelCopyWithImpl<$Res, DiaryCardModel>;
  @useResult
  $Res call(
      {String docId,
      String name,
      String alias,
      String imageUrl,
      DiaryModel diary});

  $DiaryModelCopyWith<$Res> get diary;
}

/// @nodoc
class _$DiaryCardModelCopyWithImpl<$Res, $Val extends DiaryCardModel>
    implements $DiaryCardModelCopyWith<$Res> {
  _$DiaryCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? name = null,
    Object? alias = null,
    Object? imageUrl = null,
    Object? diary = null,
  }) {
    return _then(_value.copyWith(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      diary: null == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $DiaryModelCopyWith<$Res> get diary {
    return $DiaryModelCopyWith<$Res>(_value.diary, (value) {
      return _then(_value.copyWith(diary: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DiaryCardModelCopyWith<$Res>
    implements $DiaryCardModelCopyWith<$Res> {
  factory _$$_DiaryCardModelCopyWith(
          _$_DiaryCardModel value, $Res Function(_$_DiaryCardModel) then) =
      __$$_DiaryCardModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docId,
      String name,
      String alias,
      String imageUrl,
      DiaryModel diary});

  @override
  $DiaryModelCopyWith<$Res> get diary;
}

/// @nodoc
class __$$_DiaryCardModelCopyWithImpl<$Res>
    extends _$DiaryCardModelCopyWithImpl<$Res, _$_DiaryCardModel>
    implements _$$_DiaryCardModelCopyWith<$Res> {
  __$$_DiaryCardModelCopyWithImpl(
      _$_DiaryCardModel _value, $Res Function(_$_DiaryCardModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? name = null,
    Object? alias = null,
    Object? imageUrl = null,
    Object? diary = null,
  }) {
    return _then(_$_DiaryCardModel(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      alias: null == alias
          ? _value.alias
          : alias // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      diary: null == diary
          ? _value.diary
          : diary // ignore: cast_nullable_to_non_nullable
              as DiaryModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DiaryCardModel implements _DiaryCardModel {
  _$_DiaryCardModel(
      {required this.docId,
      required this.name,
      required this.alias,
      required this.imageUrl,
      required this.diary});

  factory _$_DiaryCardModel.fromJson(Map<String, dynamic> json) =>
      _$$_DiaryCardModelFromJson(json);

  @override
  final String docId;
  @override
  final String name;
  @override
  final String alias;
  @override
  final String imageUrl;
  @override
  final DiaryModel diary;

  @override
  String toString() {
    return 'DiaryCardModel(docId: $docId, name: $name, alias: $alias, imageUrl: $imageUrl, diary: $diary)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiaryCardModel &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.alias, alias) || other.alias == alias) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.diary, diary) || other.diary == diary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, docId, name, alias, imageUrl, diary);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiaryCardModelCopyWith<_$_DiaryCardModel> get copyWith =>
      __$$_DiaryCardModelCopyWithImpl<_$_DiaryCardModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiaryCardModelToJson(
      this,
    );
  }
}

abstract class _DiaryCardModel implements DiaryCardModel {
  factory _DiaryCardModel(
      {required final String docId,
      required final String name,
      required final String alias,
      required final String imageUrl,
      required final DiaryModel diary}) = _$_DiaryCardModel;

  factory _DiaryCardModel.fromJson(Map<String, dynamic> json) =
      _$_DiaryCardModel.fromJson;

  @override
  String get docId;
  @override
  String get name;
  @override
  String get alias;
  @override
  String get imageUrl;
  @override
  DiaryModel get diary;
  @override
  @JsonKey(ignore: true)
  _$$_DiaryCardModelCopyWith<_$_DiaryCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}
