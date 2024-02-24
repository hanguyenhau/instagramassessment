import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_state.dart';
import 'package:instagram_assessment/features/authentication/data/backend/authenticator.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {

  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        authResult: AuthResult.success,
        isLoading: false,
        userid: _authenticator.userId,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.coppiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(uId: userId);
    }
    state = AuthState(
      userid: _authenticator.userId,
      authResult: result,
      isLoading: false,
    );
  }

  Future<void> logOut() async {
    state = state.coppiedWithIsLoading(true);
    await _authenticator.signOut();
    state = const AuthState.unknown();
  }

  Future<void> saveUserInfo({required UserId uId}) =>
      _userInfoStorage.saveUserInfo(
          uId: uId,
          uName: _authenticator.displayName,
          uEmail: _authenticator.email,
          uImage: _authenticator.image);
}
