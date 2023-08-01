// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InformationModel _$InformationModelFromJson(Map<String, dynamic> json) {
  return _InformationModel.fromJson(json);
}

/// @nodoc
mixin _$InformationModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  List<TipModel> get tips => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InformationModelCopyWith<InformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InformationModelCopyWith<$Res> {
  factory $InformationModelCopyWith(
          InformationModel value, $Res Function(InformationModel) then) =
      _$InformationModelCopyWithImpl<$Res, InformationModel>;
  @useResult
  $Res call({String id, String name, String imageUrl, List<TipModel> tips});
}

/// @nodoc
class _$InformationModelCopyWithImpl<$Res, $Val extends InformationModel>
    implements $InformationModelCopyWith<$Res> {
  _$InformationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? tips = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tips: null == tips
          ? _value.tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<TipModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InformationModelCopyWith<$Res>
    implements $InformationModelCopyWith<$Res> {
  factory _$$_InformationModelCopyWith(
          _$_InformationModel value, $Res Function(_$_InformationModel) then) =
      __$$_InformationModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String imageUrl, List<TipModel> tips});
}

/// @nodoc
class __$$_InformationModelCopyWithImpl<$Res>
    extends _$InformationModelCopyWithImpl<$Res, _$_InformationModel>
    implements _$$_InformationModelCopyWith<$Res> {
  __$$_InformationModelCopyWithImpl(
      _$_InformationModel _value, $Res Function(_$_InformationModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? tips = null,
  }) {
    return _then(_$_InformationModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tips: null == tips
          ? _value._tips
          : tips // ignore: cast_nullable_to_non_nullable
              as List<TipModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InformationModel implements _InformationModel {
  _$_InformationModel(
      {this.id = '',
      this.name = '',
      this.imageUrl = '',
      final List<TipModel> tips = const []})
      : _tips = tips;

  factory _$_InformationModel.fromJson(Map<String, dynamic> json) =>
      _$$_InformationModelFromJson(json);

  @override
  @JsonKey()
  final String id;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String imageUrl;
  final List<TipModel> _tips;
  @override
  @JsonKey()
  List<TipModel> get tips {
    if (_tips is EqualUnmodifiableListView) return _tips;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tips);
  }

  @override
  String toString() {
    return 'InformationModel(id: $id, name: $name, imageUrl: $imageUrl, tips: $tips)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InformationModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(other._tips, _tips));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, imageUrl,
      const DeepCollectionEquality().hash(_tips));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InformationModelCopyWith<_$_InformationModel> get copyWith =>
      __$$_InformationModelCopyWithImpl<_$_InformationModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InformationModelToJson(
      this,
    );
  }
}

abstract class _InformationModel implements InformationModel {
  factory _InformationModel(
      {final String id,
      final String name,
      final String imageUrl,
      final List<TipModel> tips}) = _$_InformationModel;

  factory _InformationModel.fromJson(Map<String, dynamic> json) =
      _$_InformationModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  List<TipModel> get tips;
  @override
  @JsonKey(ignore: true)
  _$$_InformationModelCopyWith<_$_InformationModel> get copyWith =>
      throw _privateConstructorUsedError;
}
