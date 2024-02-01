import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/user_infor/models/user.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/user/horizontal/other_user_image.dart';

class UserDetailsTile extends StatelessWidget {
  final User userInfo;
  const UserDetailsTile({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: OtherUserImage(
        profileImage: userInfo.image,
        dimension: Dimension.height50,
        borderWeight: Dimension.borderWeight2,
      ),
      title: Text(
        userInfo.displayName,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.more_vert),
      ),
    );
  }
}
