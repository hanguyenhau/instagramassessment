import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/comment/repository/comment_repository.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final commentProvider = StateNotifierProvider<CommentController, bool>((ref) =>
    CommentController(
        commentRepository: ref.watch(commentRepositoryProvider), ref: ref));

final allCommentsProvider = StreamProvider.family((ref, PostId postId) {
  final commentController = ref.watch(commentProvider.notifier);
  return commentController.allComments(postId);
});

final hasLikeCommentProvider = Provider.family.autoDispose<bool, Comment>(
  (ref, Comment comment) {
    final commentController = ref.watch(commentProvider.notifier);
    return commentController.hasLike(comment);
  },
);

final likeDislikeCommentProvider = FutureProvider.family
    .autoDispose<void, Comment>((ref, Comment comment) async {
  final commentController = ref.watch(commentProvider.notifier);
  return commentController.likeDisLikeComment(comment);
});

final commentsAndResponsesQuantityProvider =
    Provider.family.autoDispose<int, PostId>((ref, PostId postId) {
  final comments = ref.watch(allCommentsProvider(postId));
  return comments.when(
    data: (comment) {
      if (comment.isEmpty) {
        return 0;
      }
      return comment.fold<int>(0, (total, com) {
            final responses = ref.watch(allResponsesProvider(com.commentId));

            return total + (responses.value?.length ?? 0);
          }) +
          comment.length;
    },
    error: (error, stackTrace) => 0,
    loading: () => 0,
  );
});

class CommentController extends StateNotifier<IsLoading> {
  final CommentRepository _commentRepository;
  final Ref _ref;

  CommentController(
      {required CommentRepository commentRepository, required Ref ref})
      : _commentRepository = commentRepository,
        _ref = ref,
        super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required PostId postId,
    required String comment,
  }) async {
    isLoading = true;
    final result = await _commentRepository.createComment(
        userId: _ref.read(userProvider)!, postId: postId, comment: comment);
    isLoading = false;
    return result;
  }

  Stream<Iterable<Comment>> allComments(PostId postId) {
    isLoading = false;
    return _commentRepository.allComments(postId);
  }

  Stream<Comment> commentById(CommentId commentId) {
    isLoading = false;
    return _commentRepository.commentById(commentId);
  }

  bool hasLike(Comment comment) {
    isLoading = false;
    return _commentRepository.hasLike(comment, _ref.read(userProvider)!);
  }

  Future<void> likeDisLikeComment(Comment comment) async {
    isLoading = false;
    return _commentRepository.likeDislikeComment(
        comment, _ref.read(userProvider)!);
  }
}
