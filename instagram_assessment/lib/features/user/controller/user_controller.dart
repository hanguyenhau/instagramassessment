import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/user/data/data_source/user_storage.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';

final userProvider = StateNotifierProvider<UserController, UserId?>(
  (ref) => UserController(
    storage: ref.watch(userStorageProvider),
    ref: ref,
  ),
);

class UserController extends StateNotifier<UserId?> {
  final UserStorage _storage;
  final Ref _ref;

  UserController({required UserStorage storage, required Ref ref})
      : _storage = storage,
        _ref = ref,
        super(null) {
    state = _ref.watch(authProvider.notifier).currentId;
  }

  void updateState(UserId? userId) {
    state = userId;
  }

  Future<UserModel> userById(UserId userId) {
    return _storage.getUserData(uId: userId);
  }
}
