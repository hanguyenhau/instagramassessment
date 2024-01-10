import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/other_user_profile_image_view.dart';

class PostMainView extends StatelessWidget {
  const PostMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OtherUserProfileImageView(
                    profileImage: AssetsPath.testUserImage,
                    dimensionImage: 50, borderWeight: 2,)
              ],
            )
          ],
        )
      ],
    );
  }
}
