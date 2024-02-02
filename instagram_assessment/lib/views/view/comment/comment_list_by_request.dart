import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/provider/comments_post_provider.dart';
import 'package:instagram_assessment/views/view/comment/comment_details_tile.dart';
import 'package:instagram_assessment/views/view/comment/extension/height_comment_dialog.dart';

class CommentListByRequest extends ConsumerWidget {
  final CommentPostRequest request;

  const CommentListByRequest({required this.request, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comments = ref.watch(commentsPostProvider(request));

    return SizedBox(
        height: MediaQuery.of(context).size.height * 3.getHeightCommentDialog(),
        child: comments.when(
          data: (comments) {
            if (comments.isEmpty) {
              return const SizedBox();
            }

            return RefreshIndicator(
              onRefresh: () {
                ref.refresh(commentsPostProvider(request));
                return Future.delayed(
                  const Duration(seconds: 1),
                );
              },
              child: ListView.builder(
                itemBuilder: (context, index) => CommentDetailsTile(
                  comment: comments.elementAt(index),
                ),
                itemCount: comments.length,
              ),
            );
          },
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const Text('Loading'),
        ));
  }
}
