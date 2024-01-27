import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';

class CreateNewPostStyles {
  static TextStyle hintTextStyle = TextStyle(
    color: AppColor.callToActionText,
  );

  static UnderlineInputBorder focusedInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: AppColor.callToActionButton,
    ),
  );

  static BoxDecoration buttonDecoration(bool isEnabled) {
    return BoxDecoration(
      color: isEnabled ? AppColor.facebookColor : AppColor.callToActionButton,
      borderRadius: BorderRadius.circular(Dimension.circular10),
    );
  }
}