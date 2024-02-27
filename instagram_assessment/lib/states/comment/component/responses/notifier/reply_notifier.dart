import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/reply_request.dart';

class ReplyNotifier extends StateNotifier<ReplyRequest> {
  ReplyNotifier() : super(const ReplyRequest.unknown());

  void setReply(bool value, CommentId commentId) {
    state = ReplyRequest(
      isReply: value,
      commentId: commentId,
    );
  }

  void setUnknown() {
    state = const ReplyRequest.unknown();
  }
}
