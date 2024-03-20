import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/user/data/follow_request.dart';
import 'package:instagram_assessment/features/user/repository/user_repository.dart';
import 'package:instagram_assessment/models/follow.dart';
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

final userByIdProvider =
    StreamProvider.family.autoDispose((ref, UserId userId) {
  final userController = ref.watch(userProvider.notifier);
  return userController.userInfoById(userId);
});

final followingToProvider = FutureProvider.family
    .autoDispose<bool, FollowRequest>((ref, FollowRequest request) {
  final userController = ref.watch(userProvider.notifier);
  return userController.followingTo(request: request);
});

final unFollowingToProvider = FutureProvider.family
    .autoDispose<bool, FollowRequest>((ref, FollowRequest request) {
  final userController = ref.watch(userProvider.notifier);
  return userController.unFollowingTo(request: request);
});

final retrieveFollowingsProvider = StreamProvider.family.autoDispose((
  ref,
  String? uDocumentId,
) {
  final userController = ref.watch(userProvider.notifier);
  return userController.retrieveFollowings(uDocumentId: uDocumentId);
});

final retrieveFollowersProvider =
    StreamProvider.family.autoDispose((ref, String? uDocumentId) {
  final userController = ref.watch(userProvider.notifier);
  return userController.retrieveFollowers(uDocumentId: uDocumentId);
});

final findFollowProvider =
    StreamProvider.family.autoDispose((ref, String? tDocumentId) {
  final userController = ref.watch(userProvider.notifier);
  return userController.findFollowByUser(tDocumentId: tDocumentId);
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

  Stream<UserModel> userInfoById(UserId userId) =>
      _repo.getUserData(uId: userId);

  Stream<UserModel> currentUser() => _repo.getUserData(uId: state!);

  Future<bool> followingTo({required FollowRequest request}) async =>
      await _repo.followingTo(request: request);

  Future<bool> unFollowingTo({required FollowRequest request}) async =>
      await _repo.unFollowingTo(request: request);

  Stream<Iterable<Follow>> retrieveFollowings({
    required String? uDocumentId,
  }) =>
      _repo.retrieveFollows(
          uDocumentId: uDocumentId,
          collectionName: FirebaseFieldName.following);

  Stream<Iterable<Follow>> retrieveFollowers({
    required String? uDocumentId,
  }) =>
      _repo.retrieveFollows(
          uDocumentId: uDocumentId,
          collectionName: FirebaseFieldName.followers);

  Stream<Iterable<Follow>> findFollowByUser({
    required String? tDocumentId,
  }) =>
      _repo.findFollowByUser(tDocumentId: tDocumentId, cUserId: state!);
}
