import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  final dio = Dio();

  AuthRepository();

  Future<void> login() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      print('로그인중로그인중로그인중로그인중로그인중로그인중로그인중 $isInstalled');
      if (isInstalled) {
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();

        final url = Uri.https('kapi.kakao.com', '/v2/user/me');
        final resp = await dio.get(
          '$url',
          options: Options(
            headers: {
              'authorization': 'Bearer ${token.accessToken}',
            },
          ),
        );
        print('카카오톡으로 로그인 성공 ${token.accessToken}');
        print(resp.toString());
      } else {
        return;
      }
    } catch (error) {
      print('카카오톡으로 로그인 실패 $error');
    }
  }
}
