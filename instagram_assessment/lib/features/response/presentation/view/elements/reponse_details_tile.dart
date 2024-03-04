import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/models/response.dart';
import 'package:instagram_assessment/features/response/presentation/view/elements/tiles/like_total_response.dart';
import 'package:instagram_assessment/features/response/presentation/view/elements/tiles/reply_respose.dart';
import 'package:instagram_assessment/features/response/presentation/view/elements/styles/response_style.dart';
import 'package:instagram_assessment/features/comment/presentation/elements/style/comment_details_tiledart';

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
      userByIdProvider(response.userId),
    );

    return userInfo.when(
      data: (user) => ListTile(
          contentPadding: CommentDetailTileStyles.contentPaddingResponse,
          // owner comment display name
          title: const ResponseTileStyle().responseUserName(user.displayName),

          // owner comment image
          leading: const ResponseTileStyle().responseUserImage(user.image),
          subtitle: SubtileAndReplyResponse(
            response: response,
            commentController: commentController,
            comment: comment
          ),
          trailing: HasLikeAndQuantityResponse(
            commentId: comment.commentId,
            response: response,
            userId: user.userId,
          )),
      error: (error, stackTrace) => const Text('error'),
      loading: () => const Text('loading'),
    );
  }
}
