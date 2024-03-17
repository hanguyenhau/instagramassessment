import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_details_tile.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class CommentDetailsView extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const CommentDetailsView({
    required this.commentController,
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch the isReply for setting controller
    final isReply = ref.watch(replyRequestProvider);

    //current user for reply reuqest
    final currentUser = ref.watch(currentUserProvider);

    return currentUser.when(
      data: (user) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //comment content
              Text(
                comment.comment,
                maxLines: Dimension.maxLines2,
                style: CommentDetailTileStyles.textComment,
              ),

              // replies comment
              GestureDetector(
                onTap: isReply==null
                    ? () {
                        commentController.text = '@${user.name} ';
                        ref
                            .read(replyRequestProvider.notifier).update((state) => comment.commentId);
                            // .setReply(true, comment.commentId);
                      }
                    : null,
                child: Text(
                  TextMessage.reply,
                  style: CommentDetailTileStyles.textReply,
                ),
              ),
            ]);
      },
      error: (error, stackTrace) => const Text('error'),
      loading: () => const Text('loading'),
    );
  }
}
