import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/provider/send_comment_provider.dart';
import 'package:instagram_assessment/states/comment/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/responses/models/response_request.dart';
import 'package:instagram_assessment/states/comment/responses/provider/send_reponse_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/view/comment/extension/dismiss_keyboard.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_input_text_styles.dart';
import 'package:instagram_assessment/views/view/comment/widget/comment_text_field.dart';

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
    final user = ref.read(currentUserDetailProvider);
    if (user == null) {
      return const SizedBox();
    }
    final reply = ref.watch(replyProvider);
    log('reply here: ${reply.isReply}  comment: ${reply.comment?.comment}');

    return Container(
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
                //Reply by
                reply.isReply
                    ? CommentnputTextStyles.replyByUser(commentController.text)
                    : const SizedBox(),
                //divider
                reply.isReply
                    ? CommentnputTextStyles.divider
                    : const SizedBox(),

                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Expanded(
                    child: CommentTextField(
                      controller: commentController,
                      userName: user.displayName,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (hasText) {
                        final isSent = !reply.isReply
                            ? await ref
                                .read(sendCommentProvider.notifier)
                                .sendComment(
                                  userId: user.userId,
                                  postId: postId,
                                  comment: commentController.text,
                                )
                            : await ref
                                .read(sendResponseProvider.notifier)
                                .sendResponse(
                                    request: ResponseRequest(
                                        response: Response(
                                            comment: commentController.text,
                                            userId: user.userId,
                                            createAt: DateTime.now()),
                                        comment: reply.comment!));

                        if (isSent) {
                          commentController.clear;
                          dismissKeyboard();
                          ref.watch(replyProvider.notifier).setUnknown();
                        }
                      }
                    },
                    icon: const Icon(Icons.arrow_upward),
                    color: hasText
                        ? AppColor.whiteColor
                        : AppColor.callToActionText,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith<Color>((states) =>
                                hasText
                                    ? AppColor.facebookColor
                                    : AppColor.callToActionButton)),
                  ),
                ])
              ],
            )),
      ),
    );
  }
}
