import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/extension/main_exception.dart';
import 'package:instagram_assessment/features/comment/data/data_source/comment_storage.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/comment_payload.dart';
import 'package:instagram_assessment/models/like_interaction.dart';
import 'package:instagram_assessment/models/typedef.dart';

final commentRepositoryProvider = Provider(
  (ref) => CommentRepository(
    storage: ref.watch(commentStorageProvider),
  ),
);

@immutable
class CommentRepository {
  final CommentStorage _storage;

  const CommentRepository({required CommentStorage storage})
      : _storage = storage;

  Future<bool> createComment({
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    final payLoad = CommentPayLoad(
      comment: comment,
      postId: postId,
      userId: userId,
    );
    return await _storage.createComment(payLoad);
  }

  Stream<Iterable<Comment>> allComments(PostId postId) =>
      _storage.allComments(postId).map((event) =>
          event.applySortingFrom(DateSorting.newestOnTop) as dynamic);

  Stream<Comment> commentById(CommentId commentId) =>
      _storage.commentById(commentId);

  bool hasLike(Comment comment, UserId userId) =>
      //if list likes exist
      Set.from(comment.likes.map((like) => like.userId)).contains(userId);

  Future<void> likeDislikeComment(Comment comment, UserId userId) async =>
      hasLike(comment, userId)
          ? _toggleLike(comment, userId, false)
          : _toggleLike(comment, userId, true);

  Future<void> _toggleLike(Comment comment, UserId userId, bool like) async {
    final likes = Set.from(comment.likes.map((like) => like));
    if (like) {
      likes.add(LikeInteraction(
        userId: userId,
        createAt: DateTime.now(),
      ));
    } else {
      likes.removeWhere((element) => element.userId == userId);
    }
    await _storage.updateLike(comment.commentId, likes);
  }
}
