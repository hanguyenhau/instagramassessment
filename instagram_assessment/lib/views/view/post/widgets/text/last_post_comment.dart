import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/provider/last_comment_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/post/widgets/text/read_more_text_view.dart';

class LastPostComment extends ConsumerWidget {
  final PostId postId;

  const LastPostComment(
      {super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastComment = ref.watch(lastCommentPostProvider(postId));

    return lastComment.when(
        data: (comment) {
          if (comment == null) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(
              top: Dimension.height5,
              left: Dimension.width20,
              right: Dimension.width20,
            ),
            child: ReadMoreTextView(
              lastComment: comment,
            ),
          );
        },
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const SizedBox());
  }
}
