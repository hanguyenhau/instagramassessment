import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/view/create_post/styles/app_style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int maxLength;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.maxLength = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextField(
        controller: controller,
        autofocus: true,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: CreateNewPostStyles.hintTextStyle,
          focusedBorder: CreateNewPostStyles.focusedInputBorder,
          enabledBorder: CreateNewPostStyles.focusedInputBorder,
          counterText: '',
        ),
        cursorColor: AppColor.facebookColor,
      ),
    );
  }
}