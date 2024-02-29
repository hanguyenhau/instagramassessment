import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/response/repository/response_repository.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/response.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/response/data/model/like_response_request.dart';

final responseProvider = StateNotifierProvider<ResponseController, bool>(
  (ref) => ResponseController(
    repo: ref.watch(responseRepositoryProvider),
    ref: ref,
  ),
);

final allResponsesProvider = StreamProvider.family((ref, CommentId commentId) {
  final responseController = ref.watch(responseProvider.notifier);
  return responseController.allResponses(commentId);
});

final hasLikeResponseProvider = Provider.family.autoDispose<bool, Response>(
  (ref, Response response) {
    final commentController = ref.watch(responseProvider.notifier);
    return commentController.hasLike(response);
  },
);

final likeDislikeResponseProvider = FutureProvider.family
    .autoDispose<void, LikeResponseRequest>((ref, LikeResponseRequest request) async {
  final commentController = ref.watch(responseProvider.notifier);
  return commentController.likeDisLikeResponse(request: request);
});

final replyRequestProvider = StateProvider<CommentId?>((ref) => null);

class ResponseController extends StateNotifier<IsLoading> {
  final ResponseRepository _repo;
  final Ref _ref;

  ResponseController({required ResponseRepository repo, required Ref ref})
      : _repo = repo,
        _ref = ref,
        super(false);

  set isLoading(bool value) => state = value;

  Future<bool> sendResponse({
    required CommentId commentId,
    required String response,
  }) async {
    isLoading = true;
    final result = await _repo.createResponse(
        commentId: commentId,
        response: response,
        userId: _ref.read(userProvider)!);

    isLoading = false;
    return result;
  }

  Stream<Iterable<Response>> allResponses(CommentId commentId) {
    isLoading = false;
    return _repo.allResponses(commentId);
  }

  bool hasLike(Response response) {
    isLoading = false;
    return _repo.hasLike(response, _ref.read(userProvider)!);
  }

  Future<void> likeDisLikeResponse(
      {required LikeResponseRequest request}) async {
    isLoading = false;
    return _repo.likeDislikeResponse(
        request: request,
        userId: _ref.read(userProvider)!);
  }
}

