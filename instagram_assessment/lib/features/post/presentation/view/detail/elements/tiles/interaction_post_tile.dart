import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/features/comment/presentation/view/show_all_comments_dialog.dart';
import 'package:instagram_assessment/features/post/presentation/like/like_button.dart';

class InteractionPostTile extends StatelessWidget {
  final PostId postId;
  const InteractionPostTile({super.key, required this.postId});

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
                  return ShowAllCommentsDialog(
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
