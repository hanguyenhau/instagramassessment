import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/views/view/post/widgets/text/read_more_text_view.dart';

class LastPostComment extends ConsumerWidget {
  final PostId postId;

  const LastPostComment(
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
