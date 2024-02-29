import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/response.dart';

@immutable
class LikeResponseRequest {
  final Response response;
  final CommentId commentId;

  const LikeResponseRequest(
      {required this.commentId, required this.response});
}
