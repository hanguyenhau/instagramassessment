import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class HorizontalDevider extends StatelessWidget {
  final double padding;
  final bool containOr;
  const HorizontalDevider({
    super.key,
    this.padding = 0.0,
    this.containOr = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(
          padding,
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: Dimension.width10,
                  right: Dimension.width10,
                ),
                child: Divider(
                  color: AppColor.borderFavorite,
                  thickness: 0.2,
                ),
              ),
            ),
            if(containOr) Text(
              TextMessage.or,
              style: TextStyle(
                color: AppColor.dividerTextColor,
              )
            ),
            if(containOr) Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: Dimension.width10,
                  right: Dimension.width10,
                ),
                child: Divider(
                  color: AppColor.dividerColor,
                  thickness: 0.2,
                ),
              ),
            ),
          ],
        ));
  }
}
