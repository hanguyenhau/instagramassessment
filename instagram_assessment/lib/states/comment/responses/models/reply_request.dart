import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';

@immutable
class ReplyRequest {
  final bool isReply;
  final Comment? comment;

  const ReplyRequest({required this.isReply, required this.comment});

  const ReplyRequest.unknown()
      : comment = null,
        isReply = false;

  ReplyRequest setIsReply(bool value) => ReplyRequest(
        isReply: value,
        comment: comment,
      );
}
