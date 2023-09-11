// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserModelBase {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(String id, String username) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? loading,
    TResult? Function(String id, String username)? user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(String id, String username)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserModelError value) error,
    required TResult Function(UserModelLoading value) loading,
    required TResult Function(UserModel value) user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserModelError value)? error,
    TResult? Function(UserModelLoading value)? loading,
    TResult? Function(UserModel value)? user,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserModelError value)? error,
    TResult Function(UserModelLoading value)? loading,
    TResult Function(UserModel value)? user,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelBaseCopyWith<$Res> {
  factory $UserModelBaseCopyWith(
          UserModelBase value, $Res Function(UserModelBase) then) =
      _$UserModelBaseCopyWithImpl<$Res, UserModelBase>;
}

/// @nodoc
class _$UserModelBaseCopyWithImpl<$Res, $Val extends UserModelBase>
    implements $UserModelBaseCopyWith<$Res> {
  _$UserModelBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$UserModelErrorCopyWith<$Res> {
  factory _$$UserModelErrorCopyWith(
          _$UserModelError value, $Res Function(_$UserModelError) then) =
      __$$UserModelErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$UserModelErrorCopyWithImpl<$Res>
    extends _$UserModelBaseCopyWithImpl<$Res, _$UserModelError>
    implements _$$UserModelErrorCopyWith<$Res> {
  __$$UserModelErrorCopyWithImpl(
      _$UserModelError _value, $Res Function(_$UserModelError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$UserModelError(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserModelError implements UserModelError {
  _$UserModelError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'UserModelBase.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelError &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelErrorCopyWith<_$UserModelError> get copyWith =>
      __$$UserModelErrorCopyWithImpl<_$UserModelError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(String id, String username) user,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? loading,
    TResult? Function(String id, String username)? user,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(String id, String username)? user,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserModelError value) error,
    required TResult Function(UserModelLoading value) loading,
    required TResult Function(UserModel value) user,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserModelError value)? error,
    TResult? Function(UserModelLoading value)? loading,
    TResult? Function(UserModel value)? user,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserModelError value)? error,
    TResult Function(UserModelLoading value)? loading,
    TResult Function(UserModel value)? user,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class UserModelError implements UserModelBase {
  factory UserModelError(final String message) = _$UserModelError;

  String get message;
  @JsonKey(ignore: true)
  _$$UserModelErrorCopyWith<_$UserModelError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserModelLoadingCopyWith<$Res> {
  factory _$$UserModelLoadingCopyWith(
          _$UserModelLoading value, $Res Function(_$UserModelLoading) then) =
      __$$UserModelLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserModelLoadingCopyWithImpl<$Res>
    extends _$UserModelBaseCopyWithImpl<$Res, _$UserModelLoading>
    implements _$$UserModelLoadingCopyWith<$Res> {
  __$$UserModelLoadingCopyWithImpl(
      _$UserModelLoading _value, $Res Function(_$UserModelLoading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserModelLoading implements UserModelLoading {
  _$UserModelLoading();

  @override
  String toString() {
    return 'UserModelBase.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserModelLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(String id, String username) user,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? loading,
    TResult? Function(String id, String username)? user,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(String id, String username)? user,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserModelError value) error,
    required TResult Function(UserModelLoading value) loading,
    required TResult Function(UserModel value) user,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserModelError value)? error,
    TResult? Function(UserModelLoading value)? loading,
    TResult? Function(UserModel value)? user,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserModelError value)? error,
    TResult Function(UserModelLoading value)? loading,
    TResult Function(UserModel value)? user,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class UserModelLoading implements UserModelBase {
  factory UserModelLoading() = _$UserModelLoading;
}

/// @nodoc
abstract class _$$UserModelCopyWith<$Res> {
  factory _$$UserModelCopyWith(
          _$UserModel value, $Res Function(_$UserModel) then) =
      __$$UserModelCopyWithImpl<$Res>;
  @useResult
  $Res call({String id, String username});
}

/// @nodoc
class __$$UserModelCopyWithImpl<$Res>
    extends _$UserModelBaseCopyWithImpl<$Res, _$UserModel>
    implements _$$UserModelCopyWith<$Res> {
  __$$UserModelCopyWithImpl(
      _$UserModel _value, $Res Function(_$UserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
  }) {
    return _then(_$UserModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$UserModel implements UserModel {
  _$UserModel({required this.id, required this.username});

  @override
  final String id;
  @override
  final String username;

  @override
  String toString() {
    return 'UserModelBase.user(id: $id, username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, username);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelCopyWith<_$UserModel> get copyWith =>
      __$$UserModelCopyWithImpl<_$UserModel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String message) error,
    required TResult Function() loading,
    required TResult Function(String id, String username) user,
  }) {
    return user(id, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String message)? error,
    TResult? Function()? loading,
    TResult? Function(String id, String username)? user,
  }) {
    return user?.call(id, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String message)? error,
    TResult Function()? loading,
    TResult Function(String id, String username)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(id, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(UserModelError value) error,
    required TResult Function(UserModelLoading value) loading,
    required TResult Function(UserModel value) user,
  }) {
    return user(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(UserModelError value)? error,
    TResult? Function(UserModelLoading value)? loading,
    TResult? Function(UserModel value)? user,
  }) {
    return user?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(UserModelError value)? error,
    TResult Function(UserModelLoading value)? loading,
    TResult Function(UserModel value)? user,
    required TResult orElse(),
  }) {
    if (user != null) {
      return user(this);
    }
    return orElse();
  }
}

abstract class UserModel implements UserModelBase {
  factory UserModel(
      {required final String id, required final String username}) = _$UserModel;

  String get id;
  String get username;
  @JsonKey(ignore: true)
  _$$UserModelCopyWith<_$UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
