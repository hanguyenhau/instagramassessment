import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';

class OtherUserProfileImageView extends StatelessWidget {
  final String profileImage;
  final double dimensionImage;
  final double borderWeight;
  final bool grayGradientColor;
  const OtherUserProfileImageView({
    super.key,
    required this.profileImage,
    this.dimensionImage = 75,
    this.borderWeight = 3.0,
    this.grayGradientColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimensionImage,
      width: dimensionImage,
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
              width: 2.2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(100),
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
