import 'package:flutter/material.dart';
import 'package:instagram_assessment/models/post.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/views/view/like/like_total_and_userinfo_text.dart';
import 'package:instagram_assessment/views/view/post/widgets/text/last_post_comment.dart';
import 'package:instagram_assessment/views/view/post/widgets/text/view_more_post_comment.dart';
import 'package:instagram_assessment/views/view/post/widgets/tiles/post_actions_tile.dart';
import 'package:instagram_assessment/views/view/post/widgets/tiles/user_details_tile.dart';

class PostDetailsView extends StatelessWidget {
  final Post post;

  const PostDetailsView({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //user info
        UserDetailsTile(userId: post.userId),

        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: Dimension.height10,
          ),
          child: Image.network(
            post.thumbnailUrl, // Replace with your image URL
            fit: BoxFit.cover, // Adjusts the height proportionally
          ),
        ),

        //all actions: likes, comments, share
        PostActionsTile(postId: post.postId),

        //Text Like total and last user info
        LikeTotalAndUserInfoText(
          postId: post.postId,
        ),

        // last comment of post
        LastPostComment(
          postId: post.postId,
        ),

        //view more comment action
        ViewMorePostComment(
          postId: post.postId,
        ),

        const SizedBox(
          height: Dimension.height15,
        ),
      ],
    );
  }
}
