import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/views/view/comment/comments_dialog.dart';

class ViewMorePostComment extends ConsumerWidget {
  final PostId postId;
  const ViewMorePostComment({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCommentsAndResponses = ref.watch(
      commentsAndResponsesQuantityProvider(
        postId,
      ),
    );

    return Padding(
        padding: const EdgeInsets.only(
          top: Dimension.height7,
          left: Dimension.width20,
          right: Dimension.width20,
        ),
        child: GestureDetector(
          child: Text(
            'View all $allCommentsAndResponses comments',
            style: TextStyle(color: AppColor.callToActionText),
          ),
          onTap: () {
            ref.read(replyRequestProvider.notifier).update((state) => null);
            showModalBottomSheet(
              backgroundColor: Colors.white,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return CommentsDialog(
                  postId: postId,
                );
              },
            );
          },
        ));
  }
}
