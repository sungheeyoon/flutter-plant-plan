// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list_card_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ListCardModel _$ListCardModelFromJson(Map<String, dynamic> json) {
  return _ListCardModel.fromJson(json);
}

/// @nodoc
mixin _$ListCardModel {
  String get docId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  int get dDay => throw _privateConstructorUsedError;
  List<PlantField> get fields => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListCardModelCopyWith<ListCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListCardModelCopyWith<$Res> {
  factory $ListCardModelCopyWith(
          ListCardModel value, $Res Function(ListCardModel) then) =
      _$ListCardModelCopyWithImpl<$Res, ListCardModel>;
  @useResult
  $Res call(
      {String docId,
      String title,
      String imageUrl,
      int dDay,
      List<PlantField> fields});
}

/// @nodoc
class _$ListCardModelCopyWithImpl<$Res, $Val extends ListCardModel>
    implements $ListCardModelCopyWith<$Res> {
  _$ListCardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? dDay = null,
    Object? fields = null,
  }) {
    return _then(_value.copyWith(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dDay: null == dDay
          ? _value.dDay
          : dDay // ignore: cast_nullable_to_non_nullable
              as int,
      fields: null == fields
          ? _value.fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<PlantField>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ListCardModelCopyWith<$Res>
    implements $ListCardModelCopyWith<$Res> {
  factory _$$_ListCardModelCopyWith(
          _$_ListCardModel value, $Res Function(_$_ListCardModel) then) =
      __$$_ListCardModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String docId,
      String title,
      String imageUrl,
      int dDay,
      List<PlantField> fields});
}

/// @nodoc
class __$$_ListCardModelCopyWithImpl<$Res>
    extends _$ListCardModelCopyWithImpl<$Res, _$_ListCardModel>
    implements _$$_ListCardModelCopyWith<$Res> {
  __$$_ListCardModelCopyWithImpl(
      _$_ListCardModel _value, $Res Function(_$_ListCardModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? docId = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? dDay = null,
    Object? fields = null,
  }) {
    return _then(_$_ListCardModel(
      docId: null == docId
          ? _value.docId
          : docId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      dDay: null == dDay
          ? _value.dDay
          : dDay // ignore: cast_nullable_to_non_nullable
              as int,
      fields: null == fields
          ? _value._fields
          : fields // ignore: cast_nullable_to_non_nullable
              as List<PlantField>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ListCardModel implements _ListCardModel {
  _$_ListCardModel(
      {required this.docId,
      required this.title,
      required this.imageUrl,
      required this.dDay,
      required final List<PlantField> fields})
      : _fields = fields;

  factory _$_ListCardModel.fromJson(Map<String, dynamic> json) =>
      _$$_ListCardModelFromJson(json);

  @override
  final String docId;
  @override
  final String title;
  @override
  final String imageUrl;
  @override
  final int dDay;
  final List<PlantField> _fields;
  @override
  List<PlantField> get fields {
    if (_fields is EqualUnmodifiableListView) return _fields;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fields);
  }

  @override
  String toString() {
    return 'ListCardModel(docId: $docId, title: $title, imageUrl: $imageUrl, dDay: $dDay, fields: $fields)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ListCardModel &&
            (identical(other.docId, docId) || other.docId == docId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.dDay, dDay) || other.dDay == dDay) &&
            const DeepCollectionEquality().equals(other._fields, _fields));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, docId, title, imageUrl, dDay,
      const DeepCollectionEquality().hash(_fields));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ListCardModelCopyWith<_$_ListCardModel> get copyWith =>
      __$$_ListCardModelCopyWithImpl<_$_ListCardModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ListCardModelToJson(
      this,
    );
  }
}

abstract class _ListCardModel implements ListCardModel {
  factory _ListCardModel(
      {required final String docId,
      required final String title,
      required final String imageUrl,
      required final int dDay,
      required final List<PlantField> fields}) = _$_ListCardModel;

  factory _ListCardModel.fromJson(Map<String, dynamic> json) =
      _$_ListCardModel.fromJson;

  @override
  String get docId;
  @override
  String get title;
  @override
  String get imageUrl;
  @override
  int get dDay;
  @override
  List<PlantField> get fields;
  @override
  @JsonKey(ignore: true)
  _$$_ListCardModelCopyWith<_$_ListCardModel> get copyWith =>
      throw _privateConstructorUsedError;
}
