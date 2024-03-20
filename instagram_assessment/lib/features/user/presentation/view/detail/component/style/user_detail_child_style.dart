import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

@immutable
class UserDetailChildStyles {
  static get buttonPadding => const EdgeInsets.only(
      left: Dimension.width40,
      right: Dimension.width40,
      top: Dimension.height7,
      bottom: Dimension.height7);

  static buttonDecoration(Color color) => BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Dimension.circular10,
          ),
        ),
      );

  static whiteText(String text) => Text(
        text,
        style: const TextStyle(
          color: AppColor.whiteColor,
        ),
      );
  static plainText(String text) => Text(
        text,
        style: const TextStyle(
          color: Colors.black87,
        ),
      );

  static get iconContainer => BoxDecoration(
        color: AppColor.callToActionButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
      );
}
