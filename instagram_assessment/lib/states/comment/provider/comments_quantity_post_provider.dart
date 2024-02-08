import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

final commentQuantityPostProvider = Provider.family.autoDispose<int, PostId>(
  (ref, PostId postId) {
    final comments = ref.watch(
      allCommentsPostProvider(
        CommentPostRequest(postId: postId),
      ),
    );

    comments.whenData((comment) => comment.isNotEmpty ? comment.length : 0);
    return 0;
  },
);
