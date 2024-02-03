import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/comment/models/enum/date_sorting.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class CommentPostRequest {
  final PostId postId;
  final bool sortByCreateAt;
  final DateSorting dateSorting;

  const CommentPostRequest({
    required this.postId,
    this.sortByCreateAt = true,
    this.dateSorting = DateSorting.newestOnTop,
  });
}
