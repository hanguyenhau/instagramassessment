import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/post/models/post.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/home/other_user_profile_image_view.dart';
import 'package:instagram_assessment/views/view/post/dialog/comments_dialog.dart';
import 'package:instagram_assessment/views/view/post/liked_by_text_view.dart';
import 'package:instagram_assessment/views/view/post/read_more_text_view.dart';

class PostDetailsView extends ConsumerWidget {
  final Post post;
  const PostDetailsView({
    required this.post,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListTile(
          leading: const OtherUserProfileImageView(
            profileImage: AssetsPath.testUserImage,
            dimension: Dimension.height50,
            borderWeight: Dimension.borderWeight2,
          ),
          title: const Text(
            'data',
            style: TextStyle(
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
          child: Image.asset(
            AssetsPath.testPostImage, // Replace with your image URL
            fit: BoxFit.cover, // Adjusts the height proportionally
          ),
        ),
        ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {},
                child: Image.asset(
                  AssetsPath.favoriteButton,
                  width: Dimension.width21,
                  height: Dimension.height21,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Image.asset(
                  AssetsPath.commentButton,
                  width: Dimension.width30,
                  height: Dimension.height30,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Image.asset(
                  AssetsPath.shareButton,
                  width: Dimension.width20,
                  height: Dimension.width20,
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
        const Padding(
          padding: EdgeInsets.only(
            left: Dimension.width20,
            right: Dimension.width20,
          ),
          child: LikedByTextView(uName: 'Hau Hau', nLiked: 20),
        ),
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
  }
}
