import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_details_tile.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';

class LikeTotalComment extends ConsumerWidget {
  final Comment comment;
  const LikeTotalComment({required this.comment, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch the likes of comment
    final hasLike = ref.watch(hasLikeCommentProvider(comment));

    //current user for reply reuqest
    final currentUser = ref.read(currentUserProvider);

    return currentUser.when(
      data: (user) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //like comments
            GestureDetector(
              onTap: () {
                ref.read(likeDislikeCommentProvider(
                  comment,
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
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Error'),
    );
  }
}
