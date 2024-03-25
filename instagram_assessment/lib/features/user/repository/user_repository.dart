import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/features/user/data/data_source/user_storage.dart';
import 'package:instagram_assessment/features/user/data/follow_request.dart';
import 'package:instagram_assessment/models/follow.dart';
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

  Future<bool> followingTo({required FollowRequest request}) async {
    try {
      final followActions = await Future.wait([
        _storage.followUser(
          collectionName: FirebaseFieldName.following,
          documentId: request.uCurrent.documentId!,
          payload: FollowPayLoad(userId: request.uTarget.uid),
        ),
        _storage.followUser(
          collectionName: FirebaseFieldName.followers,
          documentId: request.uTarget.documentId!,
          payload: FollowPayLoad(userId: request.uCurrent.uid),
        )
      ]);
      return followActions.every((success) => success);
    } catch (_) {
      return false;
    }
  }

  Future<bool> unFollowingTo({required FollowRequest request}) async {
    try {
      final followActions = await Future.wait([
        _storage.unFollowUser(
          collectionName: FirebaseFieldName.following,
          documentId: request.uCurrent.documentId!,
          uid: request.uTarget.uid,
        ),
        _storage.unFollowUser(
          collectionName: FirebaseFieldName.followers,
          documentId: request.uTarget.documentId!,
          uid: request.uCurrent.uid,
        )
      ]);
      return followActions.every((success) => success);
    } catch (_) {
      return false;
    }
  }

  Stream<Iterable<Follow>> retrieveFollows({
    required String? uDocumentId,
    required String collectionName,
  }) =>
      _storage.retrieveFollows(
          uDocumentId: uDocumentId, collectionName: collectionName);

  Stream<Iterable<Follow>> findFollowByUser({
    required String? tDocumentId,
    required UserId cUserId,
  }) =>
      _storage.findFollowByUser(tDocumentId: tDocumentId, cUserId: cUserId);

  Future<String?> getDocumentId(UserId userId) =>
      _storage.getDocumentId(userId);
}
