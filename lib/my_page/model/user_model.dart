import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
class UserModelBase with _$UserModelBase {
  factory UserModelBase.error(String message) = UserModelError;
  factory UserModelBase.loading() = UserModelLoading;
  factory UserModelBase.user({
    required String id,
    required String username,
  }) = UserModel;
}
