import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/home/other_user_image.dart';

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
          return const Padding(
              padding: const EdgeInsets.only(right: Dimension.width18),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtherUserImage(
                    profileImage:
                        'https://firebasestorage.googleapis.com/v0/b/instagramassessment-52520.appspot.com/o/wNDHlwbuShbaPO8WHObww5wNi3z1%2Fthumbnails%2Febe71263-c1d0-4fe8-bc4c-44ea9b41c688?alt=media&token=9c84668e-2fa4-4a53-a2f3-299214e91385',
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
