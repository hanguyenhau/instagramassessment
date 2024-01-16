import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/auth_result.dart';
import 'package:instagram_assessment/models/auth_state.dart';
import 'package:instagram_assessment/states/auth/authenticator.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();

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
}
