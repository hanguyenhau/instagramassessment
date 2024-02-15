import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/comment/comments_dialog.dart';

class ViewMorePostComment extends ConsumerWidget {
  final PostId postId;
  const ViewMorePostComment({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allComments = ref.watch(
      allCommentsPostProvider(
        postId,
      ),
    );

    return allComments.when(
      data: (comments) {
        log('comment here: ${comments?.toList().toString()}');
        return Padding(
            padding: const EdgeInsets.only(
              top: Dimension.height7,
              left: Dimension.width20,
              right: Dimension.width20,
            ),
            child: GestureDetector(
              child: Text(
                'View all ${comments == null ? '' : comments.isEmpty ? 0 : comments.length} comments',
                style: TextStyle(color: AppColor.callToActionText),
              ),
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  builder: (BuildContext context) {
                    return CommentsDialog(
                      postId: postId,
                      comments: comments??[],
                    );
                  },
                );
              },
            ));
      },
      error: (error, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
