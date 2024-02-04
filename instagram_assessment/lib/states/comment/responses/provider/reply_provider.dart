import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/responses/models/reply_request.dart';
import 'package:instagram_assessment/states/comment/responses/notifier/reply_notifier.dart';

final replyProvider = StateNotifierProvider<ReplyNotifier, ReplyRequest>(
  (ref) => ReplyNotifier(),
);
