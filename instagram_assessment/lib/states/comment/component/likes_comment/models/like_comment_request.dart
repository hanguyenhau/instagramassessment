import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/comment.dart';

@immutable
class LikeCommentRequest {
  final Comment comment;
  final UserId likedBy;

  const LikeCommentRequest({required this.comment, required this.likedBy});
}
