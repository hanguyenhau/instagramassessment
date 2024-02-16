import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/features/authentication/domain/entities/user_id.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';

@immutable
class LikeResponseRequest {
  final Response response;
  final UserId likedBy;
  final CommentId commentId;

  const LikeResponseRequest(
      {required this.commentId, required this.response, required this.likedBy});
}
