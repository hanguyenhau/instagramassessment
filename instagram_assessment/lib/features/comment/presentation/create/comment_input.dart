import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/comment/presentation/create/input_comment/cancel_reply_tile.dart';
import 'package:instagram_assessment/features/comment/presentation/create/input_comment/send_comment_button.dart';
import 'package:instagram_assessment/features/comment/presentation/create/input_comment/comment_text_field.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_input.dart';

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
    final currentUser = ref.watch(currentUserProvider);

    final isReply = ref.watch(replyRequestProvider);

    return currentUser.when(
      data: (user) => Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListTile(
          leading: CommentnputTextStyles.userImage(user.image),
          //TextField get comment
          title: Container(
              decoration: CommentnputTextStyles.boxDecoration,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //cancel icon if have reply
                  isReply!=null
                      ? CancelReplyTile(displayName: user.displayName)
                      : const SizedBox(),
                  //divider
                  isReply!=null
                      ? CommentnputTextStyles.divider
                      : const SizedBox(),

                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Expanded(
                      child: CommentTextField(
                        controller: commentController,
                        userName: user.displayName,
                      ),
                    ),

                    //Send Comment
                    SendCommentButton(
                      commentController: commentController,
                      hasText: hasText,
                      postId: postId,
                      commentId: isReply,
                    ),
                  ])
                ],
              )),
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('loading'),
    );
  }
}
