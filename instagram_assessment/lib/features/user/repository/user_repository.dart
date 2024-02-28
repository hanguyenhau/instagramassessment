import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/data/data_source/user_storage.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';

final userRepositoryProvider = Provider(
  (ref) => UserRepository(
    storage: ref.watch(userStorageProvider),
  ),
);

@immutable
class UserRepository {
  final UserStorage _storage;

  const UserRepository({required UserStorage storage}) : _storage = storage;

  Stream<Iterable<UserModel>> allUsers() => _storage.allUsers();

  Stream<UserModel> getUserData({
    required UserId uId,
  }) =>
      _storage.getUserData(uId: uId);
}
