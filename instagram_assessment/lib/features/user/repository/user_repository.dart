import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/data/data_source/user_storage.dart';
import 'package:instagram_assessment/models/follow_payload.dart';
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

  Future<bool> followingTo({
    required UserId targetId,
    required UserId currentId,
  }) async {
    try {
      final followingPayLoad = FollowPayLoad(
        userId: targetId,
      );
      final followerPayload = FollowPayLoad(
        userId: currentId,
      );
      final followingSuccess =
          await _storage.followingTo(followingPayLoad, currentId);
      final followerSuccess =
          await _storage.followerBy(followerPayload, targetId);
      return followingSuccess && followerSuccess;
    } catch (_) {
      return false;
    }
  }
}
