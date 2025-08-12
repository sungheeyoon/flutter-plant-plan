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
    try {
      // Google Sign-In 초기화
      await GoogleSignIn.instance.initialize(
        serverClientId:
            '864997967184-l594qplt0fem0qfrdn2poam42pfvfces.apps.googleusercontent.com',
      );

      // 가벼운 인증 시도 (사용자 개입 없이 기존 로그인 복원)
      final account =
          await GoogleSignIn.instance.attemptLightweightAuthentication();
      if (account != null) {
        // Firebase 인증도 시도
        try {
          final googleAuth = account.authentication;
          final clientAuth = await account.authorizationClient
              .authorizationForScopes(['openid', 'email', 'profile']);

          if (googleAuth.idToken != null && clientAuth?.accessToken != null) {
            final credential = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: clientAuth!.accessToken,
            );

            final userCredential =
                await FirebaseAuth.instance.signInWithCredential(credential);
            if (userCredential.user != null) {
              state = UserModelBase.user(
                id: userCredential.user!.email!,
                username: userCredential.user!.displayName ?? '',
              );
              return;
            }
          } else {
          }
        } catch (e) {
        }
      }
    } catch (e) {
    }

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
      
      // 현재 Firebase 상태 확인
      
      // Google Sign-In 7.x에서는 currentUser 속성이 없음

      // Firebase에서 먼저 로그아웃
      try {
        await FirebaseAuth.instance.signOut();
      } catch (e) {
      }

      // Google Sign-In 세션 정리
      try {
        await GoogleSignIn.instance.signOut();
      } catch (e) {
      }

      // 초기화 (serverClientId 없이 시도)
      try {
        // 첫 번째 시도: serverClientId 없이 (google-services.json 사용)
        await GoogleSignIn.instance.initialize();
      } catch (initError1) {
        try {
          await GoogleSignIn.instance.initialize(
            serverClientId: '864997967184-l594qplt0fem0qfrdn2poam42pfvfces.apps.googleusercontent.com',
          );
        } catch (initError2) {
          state = UserModelBase.error('Google 로그인 초기화에 실패했습니다.');
          return null;
        }
      }
      

      // 시스템 레벨 문제 우회: 직접 authenticate() 호출
      
      // attemptLightweightAuthentication 건너뛰고 바로 authenticate 호출
      // 이렇게 하면 시스템 캐시 문제를 일부 우회할 수 있음
      final googleUser = await GoogleSignIn.instance.authenticate();
      

      // 인증 정보 확인
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;
      if (googleAuth.idToken == null) {
        state = UserModelBase.error('Google 인증 토큰을 받을 수 없습니다.');
        return null;
      }

      // 클라이언트 권한 요청
      final clientAuth = await googleUser!.authorizationClient
          .authorizeScopes(['openid', 'email', 'profile']);
      
      if (clientAuth?.accessToken == null) {
        state = UserModelBase.error('Google 접근 토큰을 받을 수 없습니다.');
        return null;
      }

      // Firebase 크리덴셜 생성
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: clientAuth!.accessToken,
      );

      // Firebase 연결 상태 확인
      try {
        await FirebaseAuth.instance.authStateChanges().first.timeout(Duration(seconds: 5));
      } catch (e) {
      }

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = userCredential.user;
      if (user != null) {
        
        state = UserModelBase.user(
          id: user.email!,
          username: user.displayName ?? '',
        );
      } else {
        state = UserModelBase.error('Firebase 사용자 정보를 받을 수 없습니다.');
        return null;
      }
      return user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'account-exists-with-different-credential') {
        final email = e.email;
        final pendingCred = e.credential;

        if (email == null || pendingCred == null) {
          state = UserModelBase.error('계정 정보를 가져올 수 없습니다.');
          return null;
        }


        try {
          final methods =
              await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

          if (methods.contains('google.com')) {
            final userCredential =
                await FirebaseAuth.instance.signInWithCredential(pendingCred);
            final user = userCredential.user;

            if (user != null) {
              state = UserModelBase.user(
                id: user.email!,
                username: user.displayName ?? '',
              );
              return user;
            }
          } else {
            state = UserModelBase.error(
                '이미 등록된 다른 로그인 방식이 있습니다: ${methods.join(", ")}');
            return null;
          }
        } catch (methodError) {
          state = UserModelBase.error('기존 계정 정보를 확인할 수 없습니다.');
          return null;
        }
      }

      // 기타 Firebase 에러 처리
      String errorMessage = 'Firebase 로그인에 실패했습니다';
      switch (e.code) {
        case 'network-request-failed':
          errorMessage = '네트워크 연결을 확인해주세요';
          break;
        case 'invalid-credential':
          errorMessage = '잘못된 인증 정보입니다';
          break;
        case 'user-disabled':
          errorMessage = '비활성화된 계정입니다';
          break;
        default:
          errorMessage = 'Firebase 로그인에 실패했습니다: ${e.message}';
      }

      state = UserModelBase.error(errorMessage);
      return null;
    } on GoogleSignInException catch (e) {

      switch (e.code) {
        case GoogleSignInExceptionCode.canceled:
          
          // Account reauth failed인 경우 추가 시도
          if (e.description?.contains('Account reauth failed') == true) {
            
            // 마지막 대안: 다른 serverClientId로 시도 (테스트용)
            try {
              await GoogleSignIn.instance.disconnect();
              await Future.delayed(Duration(seconds: 2));
              
              // 다른 client ID로 초기화 시도 (Web client ID 대신 Android client ID 사용)
              await GoogleSignIn.instance.initialize(
                serverClientId: null, // 기본 설정 사용
              );
              
              final retryUser = await GoogleSignIn.instance.authenticate();
              
              final googleAuth = retryUser.authentication;
              final clientAuth = await retryUser.authorizationClient.authorizeScopes(['openid', 'email', 'profile']);
              
              if (googleAuth.idToken != null && clientAuth?.accessToken != null) {
                final credential = GoogleAuthProvider.credential(
                  idToken: googleAuth.idToken,
                  accessToken: clientAuth!.accessToken,
                );
                
                final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
                final user = userCredential.user;
                
                if (user != null) {
                  state = UserModelBase.user(
                    id: user.email!,
                    username: user.displayName ?? '',
                  );
                  return user;
                }
              }
            } catch (retryError) {
            }
          }
          
          // 디바이스에서 Google 계정 설정 확인 필요
          state = UserModelBase.error('Google 계정 재인증에 실패했습니다.\n설정 > Google > 연결된 앱에서 이 앱을 제거 후 다시 시도해주세요.');
          return null;
        case GoogleSignInExceptionCode.unknownError:
          state = UserModelBase.error('Google 로그인 중 알 수 없는 오류가 발생했습니다');
          return null;
        case GoogleSignInExceptionCode.interrupted:
          state = UserModelBase.error('Google 로그인이 중단되었습니다');
          return null;
        case GoogleSignInExceptionCode.clientConfigurationError:
          state = UserModelBase.error('Google 로그인 설정에 오류가 있습니다');
          return null;
        case GoogleSignInExceptionCode.providerConfigurationError:
          state = UserModelBase.error('Google 인증 제공자 설정에 오류가 있습니다');
          return null;
        case GoogleSignInExceptionCode.uiUnavailable:
          state = UserModelBase.error('Google 로그인 UI를 표시할 수 없습니다');
          return null;
        case GoogleSignInExceptionCode.userMismatch:
          state = UserModelBase.error('Google 계정 사용자가 일치하지 않습니다');
          return null;
        default:
          state = UserModelBase.error('Google 로그인 중 오류가 발생했습니다');
      }
      return null;
    } catch (e, stackTrace) {
      state = UserModelBase.error('예상치 못한 오류가 발생했습니다');
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
    await GoogleSignIn.instance.signOut();
    await _auth.signOut();
  }

  Future<void> withdraw() async {
    await FirebaseService().deleteAccount();
    // deleteAccount()가 완료된 후에 상태를 변경
    state = UserModelBase.notLoggedIn();
  }
}
