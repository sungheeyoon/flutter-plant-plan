// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DiaryModel _$DiaryModelFromJson(Map<String, dynamic> json) {
  return _DiaryModel.fromJson(json);
}

/// @nodoc
mixin _$DiaryModel {
  String get id => throw _privateConstructorUsedError;
  @TimestampSerializer()
  DateTime get date => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get imageUrl => throw _privateConstructorUsedError;
  String get context => throw _privateConstructorUsedError;
  bool get bookMark => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DiaryModelCopyWith<DiaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DiaryModelCopyWith<$Res> {
  factory $DiaryModelCopyWith(
          DiaryModel value, $Res Function(DiaryModel) then) =
      _$DiaryModelCopyWithImpl<$Res, DiaryModel>;
  @useResult
  $Res call(
      {String id,
      @TimestampSerializer() DateTime date,
      String emoji,
      String title,
      List<String> imageUrl,
      String context,
      bool bookMark});
}

/// @nodoc
class _$DiaryModelCopyWithImpl<$Res, $Val extends DiaryModel>
    implements $DiaryModelCopyWith<$Res> {
  _$DiaryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? emoji = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? context = null,
    Object? bookMark = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String,
      bookMark: null == bookMark
          ? _value.bookMark
          : bookMark // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DiaryModelCopyWith<$Res>
    implements $DiaryModelCopyWith<$Res> {
  factory _$$_DiaryModelCopyWith(
          _$_DiaryModel value, $Res Function(_$_DiaryModel) then) =
      __$$_DiaryModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @TimestampSerializer() DateTime date,
      String emoji,
      String title,
      List<String> imageUrl,
      String context,
      bool bookMark});
}

/// @nodoc
class __$$_DiaryModelCopyWithImpl<$Res>
    extends _$DiaryModelCopyWithImpl<$Res, _$_DiaryModel>
    implements _$$_DiaryModelCopyWith<$Res> {
  __$$_DiaryModelCopyWithImpl(
      _$_DiaryModel _value, $Res Function(_$_DiaryModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? date = null,
    Object? emoji = null,
    Object? title = null,
    Object? imageUrl = null,
    Object? context = null,
    Object? bookMark = null,
  }) {
    return _then(_$_DiaryModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value._imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as List<String>,
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as String,
      bookMark: null == bookMark
          ? _value.bookMark
          : bookMark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_DiaryModel implements _DiaryModel {
  _$_DiaryModel(
      {this.id = '',
      @TimestampSerializer() required this.date,
      this.emoji = '',
      this.title = '',
      final List<String> imageUrl = const [],
      this.context = '',
      this.bookMark = false})
      : _imageUrl = imageUrl;

  factory _$_DiaryModel.fromJson(Map<String, dynamic> json) =>
      _$$_DiaryModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @TimestampSerializer()
  final DateTime date;
  @override
  @JsonKey()
  final String emoji;
  @override
  @JsonKey()
  final String title;
  final List<String> _imageUrl;
  @override
  @JsonKey()
  List<String> get imageUrl {
    if (_imageUrl is EqualUnmodifiableListView) return _imageUrl;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrl);
  }

  @override
  @JsonKey()
  final String context;
  @override
  @JsonKey()
  final bool bookMark;

  @override
  String toString() {
    return 'DiaryModel(id: $id, date: $date, emoji: $emoji, title: $title, imageUrl: $imageUrl, context: $context, bookMark: $bookMark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DiaryModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._imageUrl, _imageUrl) &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.bookMark, bookMark) ||
                other.bookMark == bookMark));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, date, emoji, title,
      const DeepCollectionEquality().hash(_imageUrl), context, bookMark);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DiaryModelCopyWith<_$_DiaryModel> get copyWith =>
      __$$_DiaryModelCopyWithImpl<_$_DiaryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DiaryModelToJson(
      this,
    );
  }
}

abstract class _DiaryModel implements DiaryModel {
  factory _DiaryModel(
      {final String id,
      @TimestampSerializer() required final DateTime date,
      final String emoji,
      final String title,
      final List<String> imageUrl,
      final String context,
      final bool bookMark}) = _$_DiaryModel;

  factory _DiaryModel.fromJson(Map<String, dynamic> json) =
      _$_DiaryModel.fromJson;

  @override
  String get id;
  @override
  @TimestampSerializer()
  DateTime get date;
  @override
  String get emoji;
  @override
  String get title;
  @override
  List<String> get imageUrl;
  @override
  String get context;
  @override
  bool get bookMark;
  @override
  @JsonKey(ignore: true)
  _$$_DiaryModelCopyWith<_$_DiaryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
