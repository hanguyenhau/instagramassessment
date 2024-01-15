import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/auth_result.dart';
import 'package:instagram_assessment/models/auth_state.dart';
import 'package:instagram_assessment/states/auth/authenticator.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  AuthStateNotifier() : super(AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      AuthState(
        authResult: AuthResult.success,
        isLoading: false,
        userid: _authenticator.userId,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    final result = await _authenticator.signInWithGoogle();
    state = AuthState(
      userid: _authenticator.userId,
      authResult: result,
      isLoading: false,
    );
  }

  Future<void> logOut () async{
    _authenticator.signOut();
    state = AuthState.unknown();
  }
}
