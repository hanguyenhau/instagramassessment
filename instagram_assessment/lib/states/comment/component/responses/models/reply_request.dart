import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';

@immutable
class ReplyRequest {
  final bool isReply;
  final CommentId? commentId;


  const ReplyRequest(
      { required this.isReply, required this.commentId});

  const ReplyRequest.unknown()
      : commentId = null,
        isReply = false;

  ReplyRequest setIsReply(bool value) => ReplyRequest(
        isReply: value,
        commentId: commentId,
      );
}
