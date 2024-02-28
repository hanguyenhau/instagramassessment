import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class SubtileAndReplyResponse extends ConsumerWidget {
  final Response response;
  final TextEditingController commentController;
  final Comment comment;

  const SubtileAndReplyResponse(
      {required this.comment,
      required this.commentController,
      required this.response,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch the isReply for setting controller
    final isReply = ref.watch(replyProvider).isReply;

    //current user for reply reuqest
    final currentUser = ref.read(currentUserProvider);

    return currentUser.when(
      data: (user) => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //comment content
            Text(
              response.comment,
              maxLines: Dimension.maxLines2,
              style: CommentDetailTileStyles.textComment,
            ),

            // replies comment
            GestureDetector(
              onTap: !isReply
                  ? () {
                      commentController.text = '@${user.displayName} ';
                      ref
                          .read(replyProvider.notifier)
                          .setReply(true, comment.commentId);
                    }
                  : null,
              child: Text(
                TextMessage.reply,
                style: CommentDetailTileStyles.textReply,
              ),
            )
          ]),
      error: (error, stackTrace) => const Text('error'),
      loading: () => const Text('loading'),
    );
  }
}
