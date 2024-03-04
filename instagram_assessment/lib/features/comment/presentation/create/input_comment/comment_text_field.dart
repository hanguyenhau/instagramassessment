import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/views/text_field/styles/flexible_text_field_style.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class CommentTextField extends StatelessWidget {
  final TextEditingController controller;
  final String userName;

  const CommentTextField({
    Key? key,
    required this.controller,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Dimension.width10,
        right: Dimension.width10,
      ),
      child: TextField(
        controller: controller,
        autofocus: true,
        maxLines: Dimension.maxLines1,
        maxLength: Dimension.maxLength200,
        decoration: InputDecoration(
          hintText: "${TextMessage.commentWithName}$userName",
          hintStyle: FlexibleTextViewStyle.hintTextStyle,
          focusedBorder: FlexibleTextViewStyle.focusedInputBorder,
          enabledBorder: FlexibleTextViewStyle.focusedInputBorder,
          counterText: '',
        ),
        cursorColor: AppColor.facebookColor,
      ),
    );
  }
}
