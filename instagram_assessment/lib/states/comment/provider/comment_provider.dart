import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/notifier/comment_notifier.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final commentProvider = StateNotifierProvider<CommentNotifier, IsLoading>(
  (_) => CommentNotifier(),
);
