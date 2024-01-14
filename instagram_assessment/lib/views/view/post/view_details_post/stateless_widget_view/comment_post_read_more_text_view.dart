import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';
import 'package:instagram_assessment/views/view/post/view_details_post/provider/toggle_comment_provider.dart';

class CommentPostReadMoreTextView extends ConsumerWidget {
  final String lastUserName;
  final String lastComment;

  const CommentPostReadMoreTextView({
    super.key,
    required this.lastUserName,
    required this.lastComment,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showMore = ref.watch(toggleCommentProvider);

    return RichText(
      text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
        TextSpan(
          text: lastUserName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text:
              //if true show all else show 100 first letters
              showMore
                  ? ' $lastComment'
                  : ' ${lastComment.substring(
                      Dimension.subString0Sequence,
                      Dimension.subString100Sequence,
                    )}',
        ),
        TextSpan(
          text: showMore
              ? ' ${TextMessage.showLess}'
              : ' ${TextMessage.showMore}',
          style: TextStyle(color: AppColor.callToActionText),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              ref.read(toggleCommentProvider.notifier).toggleShowMore();
            },
        )
      ]),
    );
  }
}
