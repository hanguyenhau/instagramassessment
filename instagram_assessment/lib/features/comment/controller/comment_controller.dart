import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/comment/repository/comment_repository.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final commentProvider = StateNotifierProvider<CommentController, bool>((ref) =>
    CommentController(
        commentRepository: ref.watch(commentRepositoryProvider), ref: ref));

final allCommentsProvider =
    StreamProvider.family.autoDispose((ref, PostId postId) {
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
    required UserId userId,
    required PostId postId,
    required String comment,
  }) async {
    isLoading = true;
    final result =
        await _commentRepository.createComment(userId, postId, comment);
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
    return _commentRepository.hasLike(comment, _ref.watch(userProvider)!);
  }

  Future<void> likeDisLikeComment(Comment comment) async {
    isLoading = false;
    return _commentRepository.likeDislikeComment(
        comment, _ref.watch(userProvider)!);
  }
}
