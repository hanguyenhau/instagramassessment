import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/comment/repository/comment_repository.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final commentProvider = StateNotifierProvider<CommentController, bool>((ref) =>
    CommentController(
        commentRepository: ref.watch(commentRepositoryProvider), ref: ref));

final allCommentsProvider = StreamProvider.family.autoDispose((ref, PostId postId) {
  final commentController = ref.watch(commentProvider.notifier);
  return commentController.allComments(postId);
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

  Stream<Comment> commentById(CommentId commentId){
    isLoading = false;
    return _commentRepository.commentById(commentId);
  }
}

