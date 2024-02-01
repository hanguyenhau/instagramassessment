import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/notifier/send_comment_notifier.dart';

final sendCommentProvider = StateNotifierProvider<SendCommentNotifier, bool>(
    (ref) => SendCommentNotifier());
