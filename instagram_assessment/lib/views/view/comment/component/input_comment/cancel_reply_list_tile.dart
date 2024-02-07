import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/responses/provider/reply_provider.dart';
import 'package:instagram_assessment/views/view/comment/style/comment_input_text_styles.dart';

class CancelReplyListTile extends ConsumerWidget {
  final String displayName;
  const CancelReplyListTile({required this.displayName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: CommentnputTextStyles.replyByUser(
        displayName,
      ),
      trailing: GestureDetector(
        onTap: () {
          ref.watch(replyProvider.notifier).setUnknown();
        },
        child: CommentnputTextStyles.iconCancel,
      ),
    );
  }
}
