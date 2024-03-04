import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

@immutable
class CommentDetailTileStyles {
  static get contentPaddingUserInfo => const EdgeInsets.only(
        top: Dimension.height5,
        bottom: Dimension.height5,
        left: Dimension.width15,
        right: Dimension.width15,
      );

  static get contentPaddingResponse => const EdgeInsets.only(
        left: Dimension.width15,
        right: Dimension.width15,
      );

  static get textUserInfo => const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: Dimension.fontSize13,
      );

  static get textReply => TextStyle(
        fontSize: Dimension.fontSize12,
        fontWeight: FontWeight.bold,
        color: AppColor.callToActionText,
      );

  static get textComment => const TextStyle(
        fontSize: Dimension.fontSize14,
      );

  static get hasLikeImage => Image.asset(
        AssetsPath.hasFavoritedButton,
        width: Dimension.width15,
        height: Dimension.height15,
      );

  static get notHasLikeImage => Image.asset(
        AssetsPath.favoriteButton,
        width: Dimension.width15,
        height: Dimension.height15,
      );

  static get likeQuantity => const TextStyle(
        color: Colors.black54,
        fontSize: Dimension.fontSize12,
      );
}
