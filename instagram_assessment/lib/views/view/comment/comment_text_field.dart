import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/view/create_post/styles/app_style.dart';

class CommentTextField extends StatelessWidget {
  const CommentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: ListTile(
        leading: Image.asset(AssetsPath.testPostImage),
        title: TextField(
          autofocus: true,
          maxLines: 2,
          decoration: InputDecoration(
            hintText: 'Comment with name Hau Ha',
            hintStyle: CreateNewPostStyles.hintTextStyle,
            focusedBorder: CreateNewPostStyles.focusedInputBorder,
            enabledBorder: CreateNewPostStyles.focusedInputBorder,
            counterText: '',
          ),
          cursorColor: AppColor.facebookColor,
        ),
      ),
    );
  }
}
