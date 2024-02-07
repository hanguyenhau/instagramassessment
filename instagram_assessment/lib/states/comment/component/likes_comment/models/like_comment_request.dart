import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';

@immutable
class LikeCommentRequest {
  final Comment comment;
  final UserId likedBy;

  const LikeCommentRequest({required this.comment, required this.likedBy});
}
