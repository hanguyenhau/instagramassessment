import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/other_user_profile_image_view.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/user_profile_image_view.dart';

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
                          dimensionImage: 75,
                          borderWeight: 3.0,
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
