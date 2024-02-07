import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
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
      userDetailInfoProvider(response.userId),
    );

    //current user for reply reuqest
    final currentUser = ref.read(currentUserDetailProvider);

    if (userInfo == null || currentUser == null) {
      return const SizedBox();
    }

    return ListTile(
        contentPadding: CommentDetailTileStyles.contentPaddingResponse,
        // owner comment display name
        title: const ResponseTileStyle().responseUserName(userInfo.displayName),

        // owner comment image
        leading: const ResponseTileStyle().responseUserImage(userInfo.image),
        subtitle: SubtileAndReplyResponse(
          response: response,
          commentController: commentController,
          comment: comment,
          currentUserName: currentUser.displayName,
        ),

        trailing: HasLikeAndQuantityResponse(
          commentId: comment.commentId,
          response: response,
          userId: userInfo.userId,
        ));
  }
}
