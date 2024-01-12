import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/user_profile_image_view.dart';

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
      padding: const EdgeInsets.all(10.0),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UserProfileImageView(
                  profileImage: AssetsPath.testUserImage,
                  includeAddButton: false,
                ),
                SizedBox(
                  height: 7,
                ),
                Text(
                  'Wallpaers 4k',
                  style: TextStyle(
                    fontSize: 14,
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
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Posts',
                style: TextStyle(
                  fontSize: 12,
                ),
              )
            ],
          ),
          Column(
            children: [
              Text(
                '60K',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Followers',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                '4',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Following',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
             
            ],
          )
        ],
      ),
    );
  }
}
