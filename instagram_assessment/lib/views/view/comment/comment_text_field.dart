import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/user_infor/provider/current_user_detail_provider.dart';
import 'package:instagram_assessment/views/components/text_field/flexible_text_field.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class CommentTextField extends ConsumerWidget {
  const CommentTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = TextEditingController();
    final user = ref.read(currentUserDetailProvider);
    if (user == null) {
      return const SizedBox();
    }
    return Container(
        color: Colors.white,
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: ListTile(
          leading: ClipOval(
            child: Image.network(
              user.image,
              fit: BoxFit.cover,
              height: 50,
              width: 50,
            ),
          ),
          title: FlexibleTextView(
            controller: commentController,
            hintText: "${TextMessage.commentWithName}${user.displayName}",
            padding: 5,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_upward),
            color: AppColor.whiteColor,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) => AppColor.facebookColor)),
          ),
        ));
  }
}
