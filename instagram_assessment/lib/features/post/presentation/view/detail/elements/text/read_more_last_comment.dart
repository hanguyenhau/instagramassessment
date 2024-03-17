import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class ReadMoreTextView extends ConsumerWidget {
  final Comment lastComment;

  const ReadMoreTextView({
    super.key,
    required this.lastComment,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showMore = ref.watch(toggleCommentProvider.notifier).update((state) => false);

    final userInfo = ref.watch(userByIdProvider(lastComment.userId));

    return userInfo.when(
      data: (user) => RichText(
        text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
          TextSpan(
            text: user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text:
                //if true show all else show 100 first letters
                showMore
                    ? ' ${lastComment.comment.substring(
                        Dimension.subString0Sequence,
                        min(Dimension.subString80Sequence,
                            lastComment.comment.length),
                      )}'
                    : ' ${lastComment.comment}',
          ),
          lastComment.comment.length > Dimension.subString80Sequence
              ? TextSpan(
                  text: showMore
                      ? ' ${TextMessage.showMore}'
                      : ' ${TextMessage.showLess}',
                  style: TextStyle(color: AppColor.callToActionText),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      ref.read(toggleCommentProvider.notifier).update((state) => true);
                    },
                )
              : const TextSpan()
        ]),
      ),
      error: (error, stackTrace) => const Text('error'),
      loading: () => const Text('loading'),
    );
  }
}
