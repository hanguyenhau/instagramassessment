import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/reply_request.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/send_reponse_provider.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/views/view/comment/extension/dismiss_keyboard.dart';

class SendCommentButton extends ConsumerWidget {
  final bool hasText;
  final ReplyRequest reply;
  final TextEditingController commentController;
  final PostId postId;
  final UserId userId;

  const SendCommentButton(
      {required this.hasText,
      required this.reply,
      required this.commentController,
      required this.postId,
      required this.userId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        if (hasText) {
          final isSent = !reply.isReply
              ? await ref.watch(commentProvider.notifier).sendComment(
                    userId: userId,
                    postId: postId,
                    comment: commentController.text,
                  )
              : await ref.watch(sendResponseProvider.notifier).sendResponse(
                    commentId: reply.commentId!,
                    response: commentController.text,
                    userId: userId,
                  );
          if (isSent) {
            commentController.clear();
            dismissKeyboard();
            ref.read(replyProvider.notifier).setUnknown();
          }
        }
      },
      icon: const Icon(Icons.arrow_upward),
      color: hasText ? AppColor.whiteColor : AppColor.callToActionText,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) =>
              hasText ? AppColor.facebookColor : AppColor.callToActionButton)),
    );
  }
}
