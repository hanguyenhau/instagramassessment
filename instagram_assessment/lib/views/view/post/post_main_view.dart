import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';
import 'package:instagram_assessment/views/view/post/stateless_widget_view/comment_post_read_more_text_view.dart';
import 'package:instagram_assessment/views/view/post/stateless_widget_view/liked_by_rich_text_view.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/other_user_profile_image_view.dart';

class PostMainView extends StatelessWidget {
  const PostMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 5,
                  ),
                  child: OtherUserProfileImageView(
                    profileImage: AssetsPath.testUserImage,
                    dimensionImage: 50,
                    borderWeight: 2,
                  ),
                ),
                Text(
                  'data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
            )
          ],
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            top: 10.0,
          ),
          child: Image.asset(
            AssetsPath.testPostImage, // Replace with your image URL
            fit: BoxFit.cover, // Adjusts the height proportionally
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 7, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  ElevatedButtonView(
                    iconName: AssetsPath.favoriteButton,
                    padding: 10,
                  ),
                  ElevatedButtonView(
                    iconName: AssetsPath.commentButton,
                    padding: 10,
                  ),
                  ElevatedButtonView(
                    iconName: AssetsPath.shareButton,
                    padding: 10,
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark_border,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: LikedByRichTextView(uName: 'Hau ha', nLiked: 20),
        ),
        const Padding(
            padding: EdgeInsets.only(
              top: 7,
              left: 20,
              right: 20,
            ),
            child: CommentPostReadMoreTextView(
              lastUserName: 'Hau Ha',
              lastComment:
                  'sjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssssssaaaaaaaaaaaaaaaaaaaaa',
            )),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 7,
          ),
          child: Text(
            'View all 103 comments',
            style: TextStyle(color: AppColor.callToActionText),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
