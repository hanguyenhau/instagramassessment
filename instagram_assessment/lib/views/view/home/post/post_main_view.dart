import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';
import 'package:instagram_assessment/views/util/view/rich_text_two_part_view.dart';
import 'package:instagram_assessment/views/view/home/post/stateless_widget_view/comment_post_read_more_text_view.dart';
import 'package:instagram_assessment/views/view/home/post/stateless_widget_view/liked_by_rich_text_view.dart';
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
                SizedBox(
                  width: 20,
                ),
                OtherUserProfileImageView(
                  profileImage: AssetsPath.testUserImage,
                  dimensionImage: 50,
                  borderWeight: 2,
                ),
                SizedBox(
                  width: 5,
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
        Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: CommentPostReadMoreTextView(
              context: context,
              lastUserName: 'Hau Ha',
              lastComment: 'sjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjssssssssssssssaaaaaaaaaaaaaaaaaaaaa',
            )),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
