import 'package:flutter/material.dart';
import 'package:instagram_assessment/models/post.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/post/presentation/like/like_details_text.dart';
import 'package:instagram_assessment/features/post/presentation/view/detail/elements/text/last_comment_view.dart';
import 'package:instagram_assessment/features/post/presentation/view/detail/elements/text/view_all_comments_text.dart';
import 'package:instagram_assessment/features/post/presentation/view/detail/elements/tiles/interaction_post_tile.dart';
import 'package:instagram_assessment/features/post/presentation/view/detail/elements/tiles/user_profile_tile.dart';

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
        UserProfileTile(userId: post.userId),

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
        InteractionPostTile(postId: post.postId),

        //Text Like total and last user info
        LikeDetailsText(
          postId: post.postId,
        ),

        // last comment of post
        LastCommentView(
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
