import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_details_tile.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/response.dart';
import 'package:instagram_assessment/features/response/data/model/like_response_request.dart';

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
