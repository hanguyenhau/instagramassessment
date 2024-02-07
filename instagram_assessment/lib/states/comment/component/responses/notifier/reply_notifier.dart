import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/reply_request.dart';

class ReplyNotifier extends StateNotifier<ReplyRequest> {
  ReplyNotifier() : super(const ReplyRequest.unknown());

  void setReply(bool value, Comment comment) {
    state = ReplyRequest(isReply: value, comment: comment);
  }

  void setUnknown(){
    state = const ReplyRequest.unknown();
  }
}
