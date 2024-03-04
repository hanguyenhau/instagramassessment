import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/response/presentation/view/show_all_responses.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/tiles/like_total_comment.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/tiles/comment_details.dart';
import 'package:instagram_assessment/features/comment/presentation/elements/style/comment_details_tiledart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const CommentTile({
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
            subtitle: CommentDetailsView(
              comment: comment,
              commentController: commentController,
            ),

            //like and quantity of like
            trailing: LikeTotalComment(
              comment: comment,
            ),
          ),
          error: (error, stackTrace) => const Text('error'),
          loading: () => const Text('loading'),
        ),

        //show response of comment
        ShowAllResponsesView(
          comment: comment,
          commentController: commentController,
        ),
      ],
    );
  }
}
