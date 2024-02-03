import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/has_like_comment_provider.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/like_dislike_comment_provider.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class CommentDetailsTile extends ConsumerWidget {
  final Comment comment;

  const CommentDetailsTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userDetailInfoProvider(comment.userId),
    );

    final currentUserId = ref.watch(userIdProvider);

    final hasLike = ref.watch(hasLikeCommentProvider(comment));

    if (userInfo == null || currentUserId == null) {
      return const SizedBox();
    }

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
          Text(
            TextMessage.reply,
            style: CommentDetailTileStyles.textReply,
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //like comments
          GestureDetector(
            onTap: () {
              ref.watch(likeDislikeCommentProvider(
                LikeCommentRequest(
                  comment: comment,
                  likedBy: currentUserId,
                ),
              ));
            },
            child: hasLike
                ? CommentDetailTileStyles.hasLikeImage
                : CommentDetailTileStyles.notHasLikeImage,
          ),
          //like quantity
          Text(
            comment.likes.length.toString(),
            style: CommentDetailTileStyles.likeQuantity,
          )
        ],
      ),
    );
  }
}
