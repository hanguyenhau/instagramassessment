import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class UploadButton extends StatelessWidget {
  final bool isPostButtonEnable;
  const UploadButton({
    super.key,
    required this.isPostButtonEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: Dimension.height40,
      margin: const EdgeInsets.only(
          bottom: Dimension.height20, top: Dimension.height20),
      decoration: BoxDecoration(
        color: isPostButtonEnable
            ? AppColor.facebookColor
            : AppColor.callToActionButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Dimension.circular10,
          ),
        ),
      ),
      child: Text(
        TextMessage.share,
        style: TextStyle(
          color: isPostButtonEnable
              ? AppColor.whiteColor
              : AppColor.callToActionText,
        ),
      ),
    );
  }
}
