import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class LikedByTextView extends StatelessWidget {
  final String uName;
  final int nLiked;
  const LikedByTextView({super.key, required this.uName, required this.nLiked});

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: TextAlign.left,
        text: TextSpan(children: [
          TextSpan(
            text: TextMessage.likedBy,
            style: TextStyle(color: AppColor.callToActionText),
          ),
          TextSpan(
              text: ' $uName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          TextSpan(
            text: ' ${TextMessage.and}',
            style: TextStyle(color: AppColor.callToActionText),
          ),
          TextSpan(
            text: ' $nLiked ${TextMessage.others}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ]));
  }
}
