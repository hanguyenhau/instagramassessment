import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/views/view/elevated_button_view.dart';

@immutable
class UserImageStyles {
  static get paddingRight => const EdgeInsets.only(
        right: Dimension.width15,
      );

  static get addButton => Positioned(
        right: Dimension.width0,
        bottom: Dimension.height0,
        child: Container(
          width: Dimension.width25,
          height: Dimension.height25,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: const BorderRadius.all(
                Radius.circular(Dimension.circular100),
              ),
              color: Colors.white),
          child: const ElevatedButtonView(
            iconName: AssetsPath.addStoryButton,
          ),
        ),
      );

  static get linearGradientDecoration => BoxDecoration(
        gradient:
            // ? LinearGradient(
            //     colors: [
            //       AppColor.borderFavorite,
            //       AppColor.borderFavorite,
            //     ],
            //   )
            // :
            LinearGradient(
          colors: [
            AppColor.yellowLinear006,
            AppColor.yellowLinearC05,
            AppColor.redLinear858,
            AppColor.blueLinearDF4,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
      );

  static get imageDecoration => BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: Dimension.width2dot2,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(Dimension.circular100),
        ),
      );
}
