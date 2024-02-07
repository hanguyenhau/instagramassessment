import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/has_like_comment_provider.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/like_dislike_comment_provider.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/responses/provider/all_response_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/view/comment/response/reponse_details_tile.dart';
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
    //userInfo of comment owner info details
    final userInfo = ref.watch(
      userDetailInfoProvider(comment.userId),
    );

    //current user for reply reuqest
    final currentUser = ref.read(currentUserDetailProvider);

    if (userInfo == null || currentUser == null) {
      return const SizedBox();
    }

    //watch the isReply for setting controller
    final isReply = ref.watch(replyProvider).isReply;

    //watch the likes of comment
    final hasLike = ref.watch(hasLikeCommentProvider(comment));

    //get reponses from comment Id;
    final reponses = ref.watch(allResponsesProvider(
      comment.commentId,
    ));

    return Flex(
direction: Axis.vertical,
      children: [
        ListTile(
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
              height: Dimension.height40,
              width: Dimension.height40,
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
                  onTap: !isReply
                      ? () {
                          commentController.text =
                              '@${currentUser.displayName} ';
                          ref
                              .read(replyProvider.notifier)
                              .setReply(true, comment);
                        }
                      : null,
                  child: Text(
                    TextMessage.reply,
                    style: CommentDetailTileStyles.textReply,
                  ),
                ),
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
              Text(
                comment.likes.length.toString(),
                style: CommentDetailTileStyles.likeQuantity,
              ),
            ],
          ),
        ),
        reponses.when(
          data: (response) {
            if (response.isEmpty) {
              return const SizedBox();
            }
            return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 55),
              child: ResponseDetailTile(
                comment: comment,
                commentController: commentController,
                response: Response(
                  comment: response.elementAt(index).comment,
                  userId: response.elementAt(index).userId,
                  createAt: response.elementAt(index).createAt,
                ),
              ),
            );
          },
          itemCount: response.length,
        );
          },
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Text("Loading"),
        ),
        
      ],
    );
  }
}


