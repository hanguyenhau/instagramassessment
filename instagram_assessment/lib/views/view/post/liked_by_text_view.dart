import 'package:flutter/material.dart';
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
          const TextSpan(
            text: TextMessage.likedBy,
          ),
          TextSpan(
              text: ' $uName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
          const TextSpan(
            text: ' ${TextMessage.and}',
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
