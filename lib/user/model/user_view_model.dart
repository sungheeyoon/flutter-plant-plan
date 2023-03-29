import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:plant_plan/user/model/social_login.dart';

class UserViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false;
  //kakao제공
  User? user;

  UserViewModel(this._socialLogin);

  Future<bool> login() async {
    isLogined = await _socialLogin.login();
    if (isLogined) {
      //kakao 현재유저정보 저장
      User user = await UserApi.instance.me();

      return true;
    } else {
      return false;
    }
  }

  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}
