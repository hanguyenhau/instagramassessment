import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/reply_request.dart';
import 'package:instagram_assessment/states/comment/component/responses/notifier/reply_notifier.dart';

final replyProvider = StateNotifierProvider<ReplyNotifier, ReplyRequest>(
  (ref) => ReplyNotifier(),
);
