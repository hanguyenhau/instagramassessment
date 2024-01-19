import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/home/other_user_profile_image_view.dart';

class UserFavoriteActivitiesListView extends StatelessWidget {
  const UserFavoriteActivitiesListView({super.key});

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
              padding: const EdgeInsets.only(right: Dimension.width18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtherUserProfileImageView(
                    profileImage: e,
                    grayGradientColor: true,
                    borderWeight: Dimension.borderWeight1,
                  ),
                  const SizedBox(
                    height: Dimension.height5,
                  ),
                  const Text('data'),
                ],
              ));
        }).toList(),
      ),
    );
  }
}
