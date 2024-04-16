
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/extension/main_exception.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/post/repository/post_repository.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/like.dart';
import 'package:instagram_assessment/models/post.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:image/image.dart' as img;

final postProvider = StateNotifierProvider<PostController, bool>(
    (ref) => PostController(repo: ref.watch(postRepositoryProvider), ref: ref));

final allPostsProvider = StreamProvider.autoDispose((ref) {
  final postController = ref.watch(postProvider.notifier);
  return postController.allPosts();
});

final allLikePostProvider = StreamProvider.family((ref, PostId postId) {
  final postController = ref.watch(postProvider.notifier);
  return postController.allLike(postId);
});

final hasLikePostProvider = StreamProvider.family<bool, PostId>(
  (ref, PostId postId) {
    final postController = ref.watch(postProvider.notifier);
    return postController.hasLike(postId: postId);
  },
);

final likePostProvider =
    FutureProvider.family.autoDispose<void, PostId>((ref, PostId postId) async {
  final commentController = ref.watch(postProvider.notifier);
  return commentController.likePost(postId: postId);
});

final disLikePostProvider =
    FutureProvider.family.autoDispose<void, PostId>((ref, PostId postId) async {
  final commentController = ref.watch(postProvider.notifier);
  return commentController.disLikePost(postId: postId);
});

final retrieveUserPostProvider =
    StreamProvider.family.autoDispose((ref, UserId userId) {
  final commentController = ref.watch(postProvider.notifier);
  return commentController.retrieveUserPost(userId: userId);
});

class PostController extends StateNotifier<IsLoading> {
  final PostRepository _repo;
  final Ref _ref;

  PostController({required PostRepository repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(false);

  set isLoading(bool value) => state = value;

  Stream<Iterable<Post>> allPosts() => _repo.allPosts();

  Stream<Iterable<Like>> allLike(PostId postId) => _repo.allLikePost(postId);

  Future<bool> uploadPost({
    required FileType filetype,
    required String messenger,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;

    switch (filetype) {
      //Type Image
      case FileType.image:
        thumbnailUint8List = _imageTypeUpload(file: _ref.watch(imagePickerProvider)!);
        break;

      case FileType.video:
        break;
    }

    final result = _repo.savePost(
        userId: _ref.read(userProvider)!,
        thumbnailUint8List: thumbnailUint8List,
        file: _ref.watch(imagePickerProvider)!,
        filetype: filetype,
        messenger: messenger);
    isLoading = false;
    log(_ref.read(userProvider)!);
    return result;
  }

  Stream<bool> hasLike({required PostId postId}) =>
      _repo.hasLike(postId: postId, userId: _ref.read(userProvider)!);

  Stream<Iterable<Post>> retrieveUserPost({required UserId userId}) =>
      _repo.retrieveUserPost(userId: userId);

  Future<void> likePost({required PostId postId}) =>
      _repo.likePost(userId: _ref.read(userProvider)!, postId: postId);

  Future<void> disLikePost({required PostId postId}) =>
      _repo.disLikePost(userId: _ref.read(userProvider)!, postId: postId);

  Uint8List _imageTypeUpload({required Uint8List file}) {
    final fileAsImage = img.decodeImage(file);
    if (fileAsImage == null) {
      isLoading = false;
      throw const CouldNotBuildThumbnailException();
    }

    final thumbnail = img.copyResize(
      fileAsImage,
      width: Dimension.imageThumbnailWidth,
    );

    final thumbnailData = img.encodeJpg(thumbnail);
    return Uint8List.fromList(thumbnailData);
  }

  void _videoTypeUpload() {}
}
