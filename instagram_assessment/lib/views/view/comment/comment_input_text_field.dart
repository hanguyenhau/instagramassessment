import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/view/comment/component/input_comment/cancel_reply_list_tile.dart';
import 'package:instagram_assessment/views/view/comment/component/input_comment/send_comment_button.dart';
import 'package:instagram_assessment/views/view/comment/component/input_comment/comment_text_field.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_input_text_styles.dart';

class CommentInputTextField extends ConsumerWidget {
  final bool hasText;
  final PostId postId;
  final TextEditingController commentController;

  const CommentInputTextField({
    required this.postId,
    required this.hasText,
    required this.commentController,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserDetailProvider);

    if (currentUser == null) {
      return const SizedBox();
    }

    final reply = ref.watch(replyProvider);

    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ListTile(
        leading: CommentnputTextStyles.userImage(currentUser.image),
        //TextField get comment
        title: Container(
            decoration: CommentnputTextStyles.boxDecoration,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //cancel icon if have reply
                reply.isReply
                    ? CancelReplyListTile(displayName: currentUser.displayName)
                    : const SizedBox(),
                //divider
                reply.isReply
                    ? CommentnputTextStyles.divider
                    : const SizedBox(),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: CommentTextField(
                      controller: commentController,
                      userName: currentUser.displayName,
                    ),
                  ),

                  //Send Comment
                  SendCommentButton(
                    commentController: commentController,
                    hasText: hasText,
                    postId: postId,
                    reply: reply,
                    userId: currentUser.userId,
                  ),
                ])
              ],
            )),
      ),
    );
  }
}
