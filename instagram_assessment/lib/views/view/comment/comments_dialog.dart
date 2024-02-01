import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/comment/app_bar_comment.dart';
import 'package:instagram_assessment/views/view/comment/comment_tile.dart';
import 'package:instagram_assessment/views/view/comment/comment_text_field.dart';

class CommentsDialog extends StatelessWidget {
  const CommentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const AppBarComment(),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) => const CommentTile(),
            ),
          ),
          const CommentTextField(),
        ],
      ),
    );
  }
}
