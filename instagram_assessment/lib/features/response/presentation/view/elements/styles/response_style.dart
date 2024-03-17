import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/comment/presentation/view/elements/style/comment_details_tile.dart';

class ResponseTileStyle {
  const ResponseTileStyle();

  Text responseUserName(String displayName) => Text(
        displayName,
        style: CommentDetailTileStyles.textUserInfo,
      );

  ClipOval responseUserImage(String imageUrl) => ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          height: Dimension.height35,
          width: Dimension.width35,
        ),
      );
}
