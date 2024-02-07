import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/view/comment/component/comment_tile/comment_list_tile.dart';

class CommentListByRequest extends ConsumerWidget {
  final PostId postId;
  final AsyncValue<Iterable<Comment>> comments;
  final TextEditingController commentController;

  const CommentListByRequest(
      {required this.commentController,
      required this.comments,
      required this.postId,
      super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return comments.when(
      data: (comments) {
        if (comments.isEmpty) {
          return const SizedBox();
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: RefreshIndicator(
            onRefresh: () {
              ref.refresh(
                allCommentsPostProvider(
                  CommentPostRequest(postId: postId),
                ),
              );
              return Future.delayed(
                const Duration(seconds: 1),
              );
            },
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CommentListTile(
                  commentController: commentController,
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
