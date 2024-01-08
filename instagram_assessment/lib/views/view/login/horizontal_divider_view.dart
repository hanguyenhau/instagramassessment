import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';

class HorizontalDevider extends StatelessWidget {
  const HorizontalDevider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(
          Dimension.height30,
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
                  color: Color(AppColor.dividerColor),
                  thickness: 0.2,
                ),
              ),
            ),
            Text(
              TextMessage.or,
              style: TextStyle(
                color: Color(AppColor.dividerTextColor),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: Dimension.width10,
                  right: Dimension.width10,
                ),
                child: Divider(
                  color: Color(AppColor.dividerColor),
                  thickness: 0.2,
                ),
              ),
            ),
          ],
        ));
  }
}
