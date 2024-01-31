import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/comment/app_bar_comment.dart';
import 'package:instagram_assessment/views/view/comment/comment_list.dart';
import 'package:instagram_assessment/views/view/comment/comment_text_field.dart';
import 'package:instagram_assessment/views/view/comment/style/border_radius_top_left_top_right.dart';

class CommentsDialog extends StatelessWidget {
  const CommentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusTopLeftTopRight.rounded,
      ),
      child: ClipRRect(
          borderRadius: BorderRadiusTopLeftTopRight.rounded,
          child: const Stack(
            children: [
              CustomScrollView(
                slivers: [
                  AppBarComment(),
                  CommentList(),
                ],
              ),
              CommentTextField(),
            ],
          )),
    );
  }
}
