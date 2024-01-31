import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/post/models/post.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/like/like_button.dart';
import 'package:instagram_assessment/views/view/like/like_total_and_userinfo_text.dart';
import 'package:instagram_assessment/views/view/user/horizontal/other_user_image.dart';
import 'package:instagram_assessment/views/view/post/dialog/comments_dialog.dart';
import 'package:instagram_assessment/views/view/post/read_more_text_view.dart';

class PostDetailsView extends ConsumerWidget {
  final Post post;
  const PostDetailsView({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userProvider(post.userId));
    return userInfo.when(
      data: (userInfo) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: OtherUserImage(
                profileImage: userInfo.image,
                dimension: Dimension.height50,
                borderWeight: Dimension.borderWeight2,
              ),
              title: Text(
                userInfo.displayName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert),
              ),
            ),
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
            ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LikeButton(postId: post.postId),
                  TextButton(
                    onPressed: () {},
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
            ),
            //Text Like total and last user info
            LikeTotalAndUserInfoText(postId: post.postId,),

            const Padding(
              padding: EdgeInsets.only(
                top: Dimension.height5,
                left: Dimension.width20,
                right: Dimension.width20,
              ),
              child: ReadMoreTextView(
                lastUserName: 'Hau Ha',
                lastComment:
                    'Start your countdown to the glorious arrival of Marvel Studios Start your countdown to the glorious arrival of Marvel Studios',
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(
                  top: Dimension.height7,
                  left: Dimension.width20,
                  right: Dimension.width20,
                ),
                child: GestureDetector(
                  child: Text(
                    'View all 103 comments',
                    style: TextStyle(color: AppColor.callToActionText),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      context: context,
                      builder: (BuildContext context) {
                        return const CommentsDialog();
                      },
                    );
                  },
                )),
            const SizedBox(
              height: Dimension.height30,
            ),
          ],
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
