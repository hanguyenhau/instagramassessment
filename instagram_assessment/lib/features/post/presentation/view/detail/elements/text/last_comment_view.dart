import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/post/presentation/view/detail/elements/text/read_more_last_comment.dart';

class LastCommentView extends ConsumerWidget {
  final PostId postId;

  const LastCommentView(
      {super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allComments = ref.watch(allCommentsProvider(postId));

    return allComments.when(
        data: (comment) {
          if (comment.isEmpty) {
            return const SizedBox();
          }
          return Padding(
            padding: const EdgeInsets.only(
              top: Dimension.height5,
              left: Dimension.width20,
              right: Dimension.width20,
            ),
            child: ReadMoreTextView(
              lastComment: comment.first,
            ),
          );
        },
        error: (error, stackTrace) => const SizedBox(),
        loading: () => const SizedBox());
  }
}
