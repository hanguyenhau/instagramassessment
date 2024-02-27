import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/total_all_responses_provider.dart';

final allCommentsAndResponsesQuantity = Provider.family.autoDispose<int, PostId>(
  (ref, PostId postId) {
    try {
      final allComments = ref.watch(
        allCommentsProvider(postId),
      );

      return allComments.when(
        data: (comments) {
          if (comments == null) {
            return 0;
          }
          var totalResponses = 0;

          for (var comment in comments) {
            final responses = ref.watch(totalAllResponses(comment.commentId));
            responses.whenData((value) => totalResponses += value);
          }

          return comments.length + totalResponses;
        },
        error: (error, stackTrace) => 0,
        loading: () => 0,
      );
    } catch (e) {
      rethrow;
    }
  },
);
