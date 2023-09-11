import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant_plan/my_page/model/user_model.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) {
    return UserMeStateNotifier();
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserMeStateNotifier() : super(UserModelBase.loading()) {
    // 앱 시작 시 현재 로그인된 사용자 정보 가져오기
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    final user = _auth.currentUser;

    if (user != null) {
      state =
          UserModelBase.user(id: user.email!, username: user.displayName ?? '');
    } else {
      state = null;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = authResult.user;
      if (user != null) {
        state = UserModelBase.user(
            id: user.email!, username: user.displayName ?? '');
      }
    } catch (e) {
      state = UserModelBase.error('로그인에 실패했습니다.');
    }
  }

  Future<void> logout() async {
    state = null;
    await _auth.signOut();
  }
}
