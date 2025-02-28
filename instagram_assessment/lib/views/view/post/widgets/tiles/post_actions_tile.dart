import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/comment/comments_dialog.dart';
import 'package:instagram_assessment/views/view/like/like_button.dart';

class PostActionsTile extends StatelessWidget {
  final PostId postId;
  const PostActionsTile({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          LikeButton(postId: postId),
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return CommentsDialog(
                    postId: postId,
                  );
                },
              );
            },
            child: Image.asset(
              AssetsPath.commentButton,
              width: Dimension.width23,
              height: Dimension.height23,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Image.asset(
              AssetsPath.shareButton,
              width: Dimension.width26,
              height: Dimension.height26,
              color: Colors.black,
              filterQuality: FilterQuality.high,
            ),
          ),
        ],
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.bookmark_border,
          color: Colors.black,
          size: Dimension.iconSize30,
        ),
      ),
    );
  }
}
