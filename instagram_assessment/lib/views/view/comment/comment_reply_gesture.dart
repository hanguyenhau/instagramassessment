import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/user_infor/models/user.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class CommentReplyGesture extends StatelessWidget {
  final TextEditingController commentController;
  final User currentUser;
  final VoidCallbackAction onPressed;
  const CommentReplyGesture(
      {super.key,
      required this.commentController,
      required this.currentUser,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        commentController.text =
            '@${currentUser.displayName} ${commentController.text}';
        // ref.watch(replyProvider.notifier).setReply(true, comment);
      },
      child: Text(
        TextMessage.reply,
        style: CommentDetailTileStyles.textReply,
      ),
    );
  }
}
