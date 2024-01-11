import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/views/view/home/post/notifier/toggle_comment_notifier.dart';

final toggleCommentProvider = StateNotifierProvider<ToggleCommentsNotifier, bool>(
  (ref) => ToggleCommentsNotifier(),
);
