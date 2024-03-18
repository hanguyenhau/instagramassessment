import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
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
      final followActions = await Future.wait([
        _storage.followUser(
          collectionName: FirebaseFieldName.following,
          userId: currentId,
          payload: FollowPayLoad(userId: targetId),
        ),
        _storage.followUser(
          collectionName: FirebaseFieldName.followers,
          userId: targetId,
          payload: FollowPayLoad(userId: currentId),
        )
      ]);

      return followActions.every((success) => success);
    } catch (_) {
      return false;
    }
  }
}
