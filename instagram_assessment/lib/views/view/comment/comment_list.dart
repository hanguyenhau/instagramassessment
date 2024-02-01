import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';

class CommentList extends StatelessWidget {
  const CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
        left: 15,
        right: 15,
      ),
      title: const Text(
        'Hau Ha',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 10,
        ),
      ),
      leading: Image.asset(AssetsPath.testUserImage),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'You are so beutiful',
            maxLines: 2,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          Text(
            'Reply',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColor.callToActionText,
            ),
          ),
        ],
      ),
      trailing: const Column(
        children: [
          FaIcon(
            FontAwesomeIcons.heart,
            size: 20,
          ),
          Text(
            '1',
            style: TextStyle(color: Colors.black54),
          )
        ],
      ),
    );
  }
}
