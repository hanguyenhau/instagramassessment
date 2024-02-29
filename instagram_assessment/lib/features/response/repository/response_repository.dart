import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/extension/sorting_by_request.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';
import 'package:instagram_assessment/features/response/data/data_source/response_source.dart';
import 'package:instagram_assessment/features/response/data/model/like_response_request.dart';
import 'package:instagram_assessment/models/like_interaction.dart';
import 'package:instagram_assessment/models/response.dart';
import 'package:instagram_assessment/models/response_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';

final responseRepositoryProvider = Provider(
  (ref) => ResponseRepository(
    storage: ref.watch(responseStorageProvider),
  ),
);

@immutable
class ResponseRepository {
  final ResponseStorage _storage;

  const ResponseRepository({required ResponseStorage storage})
      : _storage = storage;

  Future<bool> createResponse({
    required String response,
    required UserId userId,
    required CommentId commentId,
  }) async {
    final payLoad = ResponsePayLoad(
      comment: response,
      userId: userId,
    );
    return await _storage.createResponse(
        response: payLoad, commentId: commentId);
  }

  Stream<Iterable<Response>> allResponses(CommentId commentId) =>
      _storage.allResponses(commentId).map((event) =>
          event.applySortingFrom(DateSorting.newestOnTop) as dynamic);

  bool hasLike(Response response, UserId userId) =>
      //if list likes exist
      Set.from(response.likes.map((like) => like.userId)).contains(userId);

  Future<void> likeDislikeResponse(
          {required LikeResponseRequest request,
          required UserId userId}) async =>
      hasLike(request.response, userId)
          ? _toggleLike(request: request, userId: userId, like: false)
          : _toggleLike(request: request, userId: userId, like: true);

  Future<void> _toggleLike(
      {required LikeResponseRequest request,
      required UserId userId,
      required bool like}) async {
    final likes = Set.from(request.response.likes.map((like) => like));
    if (like) {
      likes.add(LikeInteraction(
        userId: userId,
        createAt: DateTime.now(),
      ));
    } else {
      likes.removeWhere((element) => element.userId == userId);
    }
    await _storage.updateLike(
      request: request,
      likes: likes,
    );
  }
}
