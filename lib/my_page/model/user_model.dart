import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String email,
    required String username,
  }) = _UserModel;

  factory UserModel.error(String message) = _UserModelError;

  factory UserModel.loading() = _UserModelLoading;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
