import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/repository/auth_repository.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);


class AuthController extends StateNotifier<IsLoading> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Future<void> loginWithGoogle() async {
    state = true;
    final currentUser = await _authRepository.loginWithGoogle();
    _ref.read(userProvider.notifier).update((state) => currentUser);
    state = false;
  }

  Future<void> logOut() async {
    state = true;
    await _authRepository.signOut();
    _ref.read(userProvider.notifier).update((state) => null);
    state = false;
  }
}
