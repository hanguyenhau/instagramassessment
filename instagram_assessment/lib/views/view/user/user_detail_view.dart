import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/home/user_profile_image_view.dart';

class UserDetailView extends StatefulWidget {
  const UserDetailView({super.key});

  @override
  State<UserDetailView> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends State<UserDetailView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(Dimension.padding10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: Dimension.width70,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserProfileImageView(
                  profileImage: AssetsPath.testUserImage,
                  includeAddButton: false,
                ),
                SizedBox(
                  height: Dimension.height7,
                ),
                Text(
                  'Wallpaers 4k',
                  style: TextStyle(
                    fontSize: Dimension.fontSize14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '1000',
                style: TextStyle(
                  fontSize: Dimension.fontSize15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                TextMessage.posts,
                style: TextStyle(
                  fontSize: Dimension.fontSize12,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                '60',
                style: TextStyle(
                  fontSize: Dimension.fontSize15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                TextMessage.followers,
                style: TextStyle(
                  fontSize: Dimension.fontSize12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: Dimension.fontSize15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                TextMessage.following,
                style: TextStyle(
                  fontSize: Dimension.fontSize12,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
