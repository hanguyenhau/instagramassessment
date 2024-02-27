import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/components/text_field/styles/flexible_text_field_style.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';

class FlexibleTextView extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final int maxLength;
  final double padding;

  const FlexibleTextView({
    Key? key,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
    this.maxLength = 200,
    this.padding = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: TextField(
        controller: controller,
        autofocus: true,
        maxLines: maxLines,
        maxLength: maxLength,
        decoration: InputDecoration(
          hintText: hintText,
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
