import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/views/view/comment/component/response/display_reponses.dart';
import 'package:instagram_assessment/views/view/comment/component/comment_tile/has_like_and_quantity_comment.dart';
import 'package:instagram_assessment/views/view/comment/component/comment_tile/subtitle_and_reply_comment.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class CommentListTile extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const CommentListTile({
    required this.commentController,
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //userInfo of comment owner info details
    final userInfo = ref.watch(
      userByIdProvider(comment.userId),
    );

    return Flex(
      direction: Axis.vertical,
      children: [
        userInfo.when(
          data: (user) => ListTile(
            contentPadding: CommentDetailTileStyles.contentPaddingUserInfo,
            // owner comment display name
            title: Text(
              user.displayName,
              style: CommentDetailTileStyles.textUserInfo,
            ),

            // owner comment image
            leading: ClipOval(
              child: Image.network(
                user.image,
                fit: BoxFit.cover,
                height: Dimension.height40,
                width: Dimension.height40,
              ),
            ),
            //Comment detail and reply
            subtitle: SubtileAndReplyComment(
              comment: comment,
              commentController: commentController,
            ),

            //like and quantity of like
            trailing: HasLikeAndQuantityComment(
              comment: comment,
            ),
          ),
          error: (error, stackTrace) => const Text('error'),
          loading: () => const Text('loading'),
        ),

        //show response of comment
        DisplayResponse(
          comment: comment,
          commentController: commentController,
        ),
      ],
    );
  }
}
