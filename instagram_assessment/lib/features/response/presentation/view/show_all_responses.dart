import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/features/response/presentation/view/elements/reponse_details_tile.dart';

class ShowAllResponsesView extends ConsumerWidget {
  final Comment comment;
  final TextEditingController commentController;

  const ShowAllResponsesView({
    super.key,
    required this.comment,
    required this.commentController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //get reponses from comment Id;
    final reponses = ref.watch(allResponsesProvider(
      comment.commentId,
    ));

    return reponses.when(
      data: (response) {
        if (response.isEmpty) {
          return const SizedBox();
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(left: 55),
              child: 
              ResponseDetailTile(
                comment: comment,
                commentController: commentController,
                response: response.elementAt(index),
              ),
            );
          },
          itemCount: response.length,
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text("Loading"),
    );
  }
}
