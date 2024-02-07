import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/responses/models/response.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class ResponseDetailTile extends ConsumerWidget {
  final Comment comment;
  final Response response;
  final TextEditingController commentController;

  const ResponseDetailTile({
    required this.comment,
    super.key,
    required this.commentController,
    required this.response,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //userInfo of comment owner info details
    final userInfo = ref.watch(
      userDetailInfoProvider(response.userId),
    );

    //current user for reply reuqest
    final currentUser = ref.read(currentUserDetailProvider);

    if (userInfo == null || currentUser == null) {
      return const SizedBox();
    }

    //watch the isReply for setting controller
    final isReply = ref.watch(replyProvider).isReply;

    //watch the likes of comment
    // final hasLike = ref.watch(hasLikeCommentProvider(comment));

    return ListTile(
      contentPadding: CommentDetailTileStyles.contentPaddingResponse,
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
          height: Dimension.height35,
          width: Dimension.width35,
        ),
      ),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //comment content
            Text(
              response.comment,
              maxLines: Dimension.maxLines2,
              style: CommentDetailTileStyles.textComment,
            ),

            // replies comment
            GestureDetector(
              onTap: !isReply
                  ? () {
                      commentController.text = '@${currentUser.displayName} ';
                      ref.read(replyProvider.notifier).setReply(true, comment);
                    }
                  : null,
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
              // ref.watch(likeDislikeCommentProvider(
              //   LikeCommentRequest(
              //     comment: comment,
              //     likedBy: currentUser.userId,
              //   ),
              // ));
            },
            child: false
                ? CommentDetailTileStyles.hasLikeImage
                : CommentDetailTileStyles.notHasLikeImage,
          ),
          //like quantity
          Text(
            '1',
            style: CommentDetailTileStyles.likeQuantity,
          ),
        ],
      ),
    );
  }
}
