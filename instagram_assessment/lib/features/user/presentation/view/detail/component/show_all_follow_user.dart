import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/presentation/view/other_user_image_test.dart';

class ShowAllFollowUser extends StatelessWidget {
  const ShowAllFollowUser({super.key});

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
            padding: EdgeInsets.only(right: Dimension.width18),
            child: OtherUserImageTest(
              profileImage:
                  'https://buffer.com/cdn-cgi/image/w=1000,fit=contain,q=90,f=auto/library/content/images/size/w1200/2023/10/free-images.jpg',
              grayGradient: true,
              borderWeight: Dimension.borderWeight1,
            ),
          );
        }).toList(),
      ),
    );
  }
}
