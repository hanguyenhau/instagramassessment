// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
// import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
// import 'package:instagram_assessment/states/post/typedef/post_id.dart';

// final quantityCommentProvider = Provider.family.autoDispose<int, PostId>(
//   (ref, PostId postId) {
//     final comments = ref.watch(
//       allCommentsPostProvider(
//         CommentPostRequest(postId: postId),
//       ),
//     );

//     return comments.when(
//       data: (comment) {
//         if (comment.isEmpty) {
//           return 0;
//         }
//         return comment.length;
//       },
//       error: (error, stackTrace) => 0,
//       loading: () => 0,
//     );
//   },
// );
