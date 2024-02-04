import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/has_like_comment_provider.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/like_dislike_comment_provider.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class CommentDetailsTile extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const CommentDetailsTile({
    required this.commentController,
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userDetailInfoProvider(comment.userId),
    );

    final currentUser = ref.read(currentUserDetailProvider);

    if (userInfo == null || currentUser == null) {
      return const SizedBox();
    }

    final hasLike = ref.watch(hasLikeCommentProvider(comment));

    return ListTile(
      contentPadding: CommentDetailTileStyles.contentPaddingUserInfo,
      // owner comment display name
      title: Text(
        userInfo.displayName,
        style: CommentDetailTileStyles.textUserInfo,
      ),

      // owner comment image
      leading: ClipOval(
        child: Image.network(
          userInfo.image,
          fit: BoxFit.cover,
          height: Dimension.height50,
          width: Dimension.width50,
        ),
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //comment content
            Text(
              comment.comment,
              maxLines: Dimension.maxLines2,
              style: CommentDetailTileStyles.textComment,
            ),

            // replies comment
            GestureDetector(
              onTap: () {
                commentController.text =
                    '@${currentUser.displayName} ${commentController.text}';
                ref.watch(replyProvider.notifier).setReply(true, comment);
              },
              child: Text(
                TextMessage.reply,
                style: CommentDetailTileStyles.textReply,
              ),
            )
          ]),

      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //like comments
          GestureDetector(
            onTap: () {
              ref.watch(likeDislikeCommentProvider(
                LikeCommentRequest(
                  comment: comment,
                  likedBy: currentUser.userId,
                ),
              ));
            },
            child: hasLike
                ? CommentDetailTileStyles.hasLikeImage
                : CommentDetailTileStyles.notHasLikeImage,
          ),
          //like quantity
          GestureDetector(
            onTap: () {
              ref.watch(replyProvider.notifier).setUnknown();
            },
            child: Text(
              comment.likes.length.toString(),
              style: CommentDetailTileStyles.likeQuantity,
            ),
          ),
        ],
      ),
    );
  }
}
