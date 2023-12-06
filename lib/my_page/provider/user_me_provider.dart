import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plant_plan/my_page/model/user_model.dart';
import 'package:plant_plan/services/firebase_service.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase>(
  (ref) {
    return UserMeStateNotifier();
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserMeStateNotifier() : super(UserModelBase.loading()) {
    // 앱 시작 시 현재 로그인된 사용자 정보 가져오기
    _initialize();
  }

  Future<void> _initialize() async {
    await _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        state = UserModelBase.user(
            id: user.email!, username: user.displayName ?? '');
      } else {
        state = UserModelBase.notLoggedIn();
      }
    } catch (e) {
      state = UserModelBase.error('사용자 정보를 가져오는 데 실패했습니다.');
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _fetchCurrentUser();
    } catch (e) {
      state = UserModelBase.error('로그인에 실패했습니다.');
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        // 사용자가 로그인을 취소한 경우
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        state = UserModelBase.user(
            id: user.email!, username: user.displayName ?? '');
      }

      return user;
    } catch (e) {
      print('Error during Google sign-in: $e');

      if (e is FirebaseAuthException) {
        // Firebase Auth 예외 처리
        print(
            'Firebase Auth Exception - Code: ${e.code}, Message: ${e.message}');

        if (e.code == 'account-exists-with-different-credential') {
          // 이미 다른 방법으로 가입된 경우
          print('이미 다른 방법으로 가입된 계정이 있습니다.');
        }
      } else {
        // 기타 예외 처리
        print('Other Exception: $e');
      }

      state = UserModelBase.error('로그인에 실패했습니다.');
      return null;
    }
  }

  Future<bool> checkPassword(
      {required String id, required String password}) async {
    try {
      final authResult = await _auth.signInWithEmailAndPassword(
        email: id,
        password: password,
      );

      final user = authResult.user;
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    final user = _auth.currentUser;
    if (user != null) {
      user.updatePassword(password);
    }
  }

  Future<void> logout() async {
    //현재 빌드가 완료된 후에 상태를 수정하도록 Future.microtask
    Future.microtask(() {
      state = UserModelBase.notLoggedIn();
    });
    await _auth.signOut();
  }

  Future<void> withdraw() async {
    await FirebaseService().deleteAccount();
    // deleteAccount()가 완료된 후에 상태를 변경
    state = UserModelBase.notLoggedIn();
  }
}
