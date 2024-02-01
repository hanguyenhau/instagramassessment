import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/post/read_more_text_view.dart';

class LastPostComment extends StatelessWidget {
  const LastPostComment({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(
        top: Dimension.height5,
        left: Dimension.width20,
        right: Dimension.width20,
      ),
      child: ReadMoreTextView(
        lastUserName: 'Hau Ha',
        lastComment:
            'Start your countdown to the glorious arrival of Marvel Studios Start your countdown to the glorious arrival of Marvel Studios',
      ),
    );
  }
}
