import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/view/comment/comment_details_tile.dart';
import 'package:instagram_assessment/views/view/comment/extension/height_comment_dialog.dart';

class CommentListByRequest extends ConsumerWidget {
  final PostId postId;
  final AsyncValue<Iterable<Comment>> comments;

  const CommentListByRequest(
      {required this.comments, required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return comments.when(
      data: (comments) {
        if (comments.isEmpty) {
          return const SizedBox();
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height *
              comments.length.getHeightCommentDialog(),
          child: RefreshIndicator(
            onRefresh: () {
              ref.refresh(
                  allCommentsPostProvider(CommentPostRequest(postId: postId)));
              return Future.delayed(
                const Duration(seconds: 1),
              );
            },
            child: ListView.builder(
              itemBuilder: (context, index) {
                return CommentDetailsTile(
                  comment: comments.elementAt(index),
                );
              },
              itemCount: comments.length,
            ),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
