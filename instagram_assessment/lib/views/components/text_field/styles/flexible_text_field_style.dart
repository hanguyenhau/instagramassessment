import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';

@immutable
class FlexibleTextViewStyle {
  static TextStyle hintTextStyle = TextStyle(
      color: AppColor.callToActionText,
      fontWeight: FontWeight.normal,
      fontSize: 14);

  static UnderlineInputBorder focusedInputBorder = const UnderlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
    ),
  );
}
