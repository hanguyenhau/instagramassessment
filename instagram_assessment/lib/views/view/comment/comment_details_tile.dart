import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/provider/like_dislike_comment_provider.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_info_provider.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';

class CommentDetailsTile extends ConsumerWidget {
  final Comment comment;

  const CommentDetailsTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userDetailInfoProvider(comment.userId),
    );

    if (userInfo == null) {
      return const SizedBox();
    }

    return ListTile(
      contentPadding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 15,
        right: 15,
      ),
      title: Text(
        userInfo.displayName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
      leading: ClipOval(
        child: Image.network(
          userInfo.image,
          fit: BoxFit.cover,
          height: 50,
          width: 50,
        ),
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            comment.comment,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            'Reply',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.callToActionText,
            ),
          ),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              ref.watch(likeDislikeCommentProvider(
                LikeCommentRequest(
                  comment: comment,
                  likedBy: userInfo.userId,
                ),
              ));
            },
            child: const FaIcon(
              FontAwesomeIcons.heart,
              size: 20,
            ),
          ),
          const Text(
            '1',
            style: TextStyle(color: Colors.black54, fontSize: 12),
          )
        ],
      ),
    );
  }
}
