import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/views/view/comment/extension/dismiss_keyboard.dart';

class SendCommentButton extends ConsumerWidget {
  final bool hasText;
  final CommentId? commentId;
  final TextEditingController commentController;
  final PostId postId;

  const SendCommentButton(
      {required this.hasText,
      required this.commentId,
      required this.commentController,
      required this.postId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () async {
        if (hasText) {
          final isSent = commentId == null
              ? await ref.watch(commentProvider.notifier).sendComment(
                    postId: postId,
                    comment: commentController.text,
                  )
              : await ref.watch(responseProvider.notifier).sendResponse(
                    commentId: commentId!,
                    response: commentController.text,
                  );
          if (isSent) {
            commentController.clear();
            dismissKeyboard();
            ref.read(replyRequestProvider.notifier).update((state) => null);
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
