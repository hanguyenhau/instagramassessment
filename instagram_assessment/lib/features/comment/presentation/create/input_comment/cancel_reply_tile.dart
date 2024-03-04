import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_input.dart';

class CancelReplyTile extends ConsumerWidget {
  final String displayName;
  const CancelReplyTile({required this.displayName, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: CommentnputTextStyles.replyByUser(
        displayName,
      ),
      trailing: GestureDetector(
        onTap: () {
          ref.read(replyRequestProvider.notifier).update((state) => null);
        },
        child: CommentnputTextStyles.iconCancel,
      ),
    );
  }
}
