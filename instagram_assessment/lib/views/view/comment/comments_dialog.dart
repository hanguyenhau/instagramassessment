import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/comment/provider/all_comments_post_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/view/comment/app_bar_comment.dart';
import 'package:instagram_assessment/views/view/comment/comment_list_by_request.dart';
import 'package:instagram_assessment/views/view/comment/comment_input_text_field.dart';

class CommentsDialog extends HookConsumerWidget {
  final PostId postId;

  const CommentsDialog({required this.postId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();

    final hasText = useState(false);

    final request = useState(CommentPostRequest(postId: postId));

    //Get all comment from post
    final comments = ref.watch(
      allCommentsPostProvider(
        request.value,
      ),
    );

    useEffect(() {
      void listener() {
        hasText.value = commentController.text.isNotEmpty;
      }

      commentController.addListener(listener);

      return () {
        commentController.removeListener(listener);
      };
    }, [commentController]);

    return SingleChildScrollView(
      child: Column(
        children: [
          //comment app bar
          const AppBarComment(),

          //comment list by request
          CommentListByRequest(
            comments: comments,
            postId: postId,
            commentController: commentController,
          ),

          //Comment textField
          CommentInputTextField(
            hasText: hasText.value,
            postId: postId,
            commentController: commentController ,
          ),
        ],
      ),
    );
  }
}
