import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/view/comment/app_bar_comment.dart';
import 'package:instagram_assessment/views/view/comment/comment_tile.dart';
import 'package:instagram_assessment/views/view/comment/comment_text_field.dart';

class CommentsDialog extends HookConsumerWidget {
  final PostId postId;
  
  const CommentsDialog({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
