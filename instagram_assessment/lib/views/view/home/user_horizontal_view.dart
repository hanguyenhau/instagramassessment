import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/view/home/other_user_profile_image_view.dart';

import 'package:instagram_assessment/views/view/home/user_profile_image_view.dart';

class UserHorizontalView extends StatelessWidget {
  const UserHorizontalView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      AssetsPath.testPostImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
      AssetsPath.testUserImage,
    ];
    return Container(
      height: 120,
      margin: const EdgeInsets.only(left: 20),
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: items.map((e) {
          return Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  e == AssetsPath.testPostImage
                      ? const UserProfileImageView(
                          profileImage: AssetsPath.testPostImage,
                        )
                      : OtherUserProfileImageView(
                          profileImage: e,
                        ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Text('data'),
                ],
              ));
        }).toList(),
      ),
    );
  }
}
