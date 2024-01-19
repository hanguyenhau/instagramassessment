import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';

class OtherUserProfileImageView extends StatelessWidget {
  final String profileImage;
  final double dimension;
  final double borderWeight;
  final bool grayGradientColor;
  const OtherUserProfileImageView({
    super.key,
    required this.profileImage,
    this.dimension = Dimension.height75,
    this.borderWeight = Dimension.borderWeight3,
    this.grayGradientColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimension,
      width: dimension,
      decoration: BoxDecoration(
        gradient: grayGradientColor
            ? LinearGradient(
                colors: [
                  AppColor.borderFavorite,
                  AppColor.borderFavorite,
                ],
              )
            : LinearGradient(
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
      ),
      child: Padding(
        padding: EdgeInsets.all(borderWeight),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: Dimension.width2dot2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(Dimension.circular100),
            ),
          ),
          child: ClipOval(
              child: Image.asset(
            profileImage,
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }
}
