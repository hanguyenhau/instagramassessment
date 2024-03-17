import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/user/repository/user_repository.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';

final userProvider = StateNotifierProvider<UserController, UserId?>(
  (ref) => UserController(
    repo: ref.watch(userRepositoryProvider),
    ref: ref,
  ),
);

final allUsersProvider = StreamProvider.autoDispose((ref) {
  final userController = ref.watch(userProvider.notifier);
  return userController.allUsers();
});

final currentUserProvider = StreamProvider.autoDispose((ref) {
  final userController = ref.watch(userProvider.notifier);
  return userController.currentUser();
});

final userByIdProvider = StreamProvider.family.autoDispose((ref, UserId userId) {
  final userController = ref.watch(userProvider.notifier);
   return userController.userInfoById(userId); 
});

class UserController extends StateNotifier<UserId?> {
  final UserRepository _repo;
  final Ref _ref;

  UserController({required UserRepository repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(null) {
    state = _ref.watch(authProvider.notifier).currentId;
  }

  void updateState(UserId? authId) {
    state = authId;
  }

  Stream<Iterable<UserModel>> allUsers() => _repo.allUsers();

  Stream<UserModel> userInfoById(UserId userId) => _repo.getUserData(uId: userId);

  Stream<UserModel> currentUser() => _repo.getUserData(uId: state!);
}
