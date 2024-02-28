import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/views/view/comment/component/response/response_tile/has_like_and_quantity_response.dart';
import 'package:instagram_assessment/views/view/comment/component/response/response_tile/subtile_and_reply_response.dart';
import 'package:instagram_assessment/views/view/comment/component/response/styles/response_tile_style.dart';
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
