import 'package:shared_preferences/shared_preferences.dart';

class LoginManager {
  static final LoginManager _instance = LoginManager._internal();
  factory LoginManager() => _instance;
  LoginManager._internal();

  SharedPreferences? _prefs;

  Future<void> initialize() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  bool get isAutoLogin => _prefs?.getBool('autoLogin') ?? true;
  bool get isShowLogin => _prefs?.getBool('showLogin') ?? false;

  Future<void> setAutoLogin(bool newValue) async {
    if (_prefs != null) {
      await _prefs!.setBool('autoLogin', newValue);
    }
  }

  Future<void> setShowLogin(bool newValue) async {
    if (_prefs != null) {
      await _prefs!.setBool('showLogin', newValue);
    }
  }
}
