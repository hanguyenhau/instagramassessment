import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_state.dart';
import 'package:instagram_assessment/features/authentication/data/repository/auth_repository.dart';
import 'package:instagram_assessment/models/user.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

class AuthController extends StateNotifier<AuthState> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(
          const AuthState.unknown(),
        ) {
    if (_authRepository.isAlreadyLoggedIn) {
      state = AuthState(
        authResult: AuthResult.success,
        isLoading: false,
        userid: _authRepository.userId,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.coppiedWithIsLoading(true);
    final result = await _authRepository.loginWithGoogle();
    state = AuthState(
      userid: _authRepository.userId,
      authResult: result,
      isLoading: false,
    );
  }

  Future<void> logOut() async {
    state = state.coppiedWithIsLoading(true);
    await _authRepository.signOut();
    state = const AuthState.unknown();
  }
}
