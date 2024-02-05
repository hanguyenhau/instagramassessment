import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

@immutable
class CommentnputTextStyles {
  static get boxDecoration => BoxDecoration(
      border: Border.all(
        color: AppColor.callToActionButton,
        width: Dimension.width2,
      ),
      borderRadius: BorderRadius.circular(Dimension.circular20));

  static userImage(String imageUrl) {
    return ClipOval(
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: Dimension.height45,
        width: Dimension.width45,
      ),
    );
  }

  static replyByUser(String userName) {
    return Text(
      '${TextMessage.replyTo} $userName',
      style: TextStyle(
        fontSize: Dimension.fontSize13,
        color: AppColor.callToActionText,
      ),
    );
  }

  static get iconCancel => Icon(
        Icons.cancel,
        color: AppColor.callToActionButton,
      );

  static get divider => Divider(
        color: AppColor.callToActionButton,
        thickness: Dimension.thickness2,
      );
}
