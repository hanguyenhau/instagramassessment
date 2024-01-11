import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';

class LikedByRichTextView extends StatelessWidget {
  final String uName;
  final int nLiked;
  const LikedByRichTextView(
      {super.key, required this.uName, required this.nLiked});

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
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const TextSpan(
            text: ' ${TextMessage.and}',
          ),
          TextSpan(
            text: ' $nLiked ${TextMessage.others}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ]));
  }
}
