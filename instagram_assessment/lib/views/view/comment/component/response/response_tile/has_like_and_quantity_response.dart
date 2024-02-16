import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/domain/entities/user_id.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/models/like_response_request.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/provider/has_like_response_provider.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/provider/like_dislike_response_provider.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_details_tile_styles.dart';

class HasLikeAndQuantityResponse extends ConsumerWidget {
  final CommentId commentId;
  final Response response;
  final UserId userId;

  const HasLikeAndQuantityResponse(
      {required this.commentId,
      required this.response,
      required this.userId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // //watch the likes of comment
    final hasLike = ref.watch(hasLikeResponseProvider(response));
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //like comments
        GestureDetector(
          onTap: () {
            ref.read(likeDislikeResponseProvider(
              LikeResponseRequest(
                commentId: commentId,
                response: response,
                likedBy: userId,
              ),
            ));
          },
          child: hasLike
              ? CommentDetailTileStyles.hasLikeImage
              : CommentDetailTileStyles.notHasLikeImage,
        ),
        //like quantity
        Text(
          response.likes.length.toString(),
          style: CommentDetailTileStyles.likeQuantity,
        ),
      ],
    );
  }
}
