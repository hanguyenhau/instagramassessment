import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/provider/send_comment_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/views/components/text_field/flexible_text_field.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/extension/dismiss_keyboard.dart';

class CommentInputTextField extends ConsumerWidget {
  final TextEditingController commentController;
  final bool hasText;
  final PostId postId;
  
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
    return Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListTile(
          leading: ClipOval(
            child: Image.network(
              user.image,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
          //TextField get comment
          title: FlexibleTextView(
            controller: commentController,
            hintText: "${TextMessage.commentWithName}${user.displayName}",
            padding: 5,
          ),
          //send button
          trailing: IconButton(
            onPressed: () async {
              if (hasText) {
                final isSent =
                    await ref.read(sendCommentProvider.notifier).sendComment(
                          userId: user.userId,
                          postId: postId,
                          comment: commentController.text,
                        );

                if (isSent) {
                  commentController.clear();
                  dismissKeyboard();
                }
              }
            },
            icon: const Icon(Icons.arrow_upward),
            color: hasText ? AppColor.whiteColor : AppColor.callToActionText,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => hasText
                        ? AppColor.facebookColor
                        : AppColor.callToActionButton)),
          ),
        ));
  }
}
