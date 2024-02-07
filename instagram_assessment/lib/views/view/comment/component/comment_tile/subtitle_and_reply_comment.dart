import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class SubtileAndReplyComment extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const SubtileAndReplyComment({
    required this.commentController,
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch the isReply for setting controller
    final isReply = ref.watch(replyProvider).isReply;

    //current user for reply reuqest
    final currentUser = ref.read(currentUserDetailProvider);

    if (currentUser == null) {
      return const SizedBox();
    }

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
            onTap: !isReply
                ? () {
                    commentController.text = '@${currentUser.displayName} ';
                    ref.read(replyProvider.notifier).setReply(true, comment);
                  }
                : null,
            child: Text(
              TextMessage.reply,
              style: CommentDetailTileStyles.textReply,
            ),
          ),
        ]);
  }
}
