import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/views/view/post/view_details_post/notifier/toggle_comment_notifier.dart';

final toggleCommentProvider = StateNotifierProvider<ToggleCommentsNotifier, bool>(
  (ref) => ToggleCommentsNotifier(),
);
