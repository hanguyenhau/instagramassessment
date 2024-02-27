import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/comment/data/data_source/comment_storage.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/comment_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/comment/extension/comment_sorting_by_request.dart';

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

  Future<bool> createComment(
    UserId userId,
    PostId postId,
    String comment,
  ) async {
    final payLoad = CommentPayLoad(
      comment: comment,
      postId: postId,
      userId: userId,
    );
    return await _storage.createComment(payLoad);
  }

  Stream<Iterable<Comment>> allComments(PostId postId) {
    return _storage
        .allComments(postId)
        .map((event) => event.applySortingFrom(DateSorting.newestOnTop));
  }

  Stream<Comment> commentById(CommentId commentId) {
    return _storage.commentById(commentId);
  }
}
