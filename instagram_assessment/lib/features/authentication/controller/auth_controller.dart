import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/repository/auth_repository.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';

final authProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<IsLoading> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  Future<void> loginWithGoogle() async {
    state = true;
    final currentUser = await _authRepository.loginWithGoogle();
    _ref.read(userProvider.notifier).updateState(currentUser?.uid);
    state = false;
  }

  Future<void> logOut() async {
    state = true;
    await _authRepository.signOut();
    _ref.read(userProvider.notifier).updateState(null);
    state = false;
  }

  UserId? get currentId => _authRepository.currentId;
}
