import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/component/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/component/likes_comment/provider/has_like_comment_provider.dart';
import 'package:instagram_assessment/states/comment/component/likes_comment/provider/like_dislike_comment_provider.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class HasLikeAndQuantityComment extends ConsumerWidget {
  final Comment comment;
  const HasLikeAndQuantityComment({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch the likes of comment
    final hasLike = ref.watch(hasLikeCommentProvider(comment));

    //current user for reply reuqest
    final currentUser = ref.read(currentUserDetailProvider);

    if (currentUser == null) {
      return const SizedBox();
    }

    return Column(
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
    );
  }
}
