import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';

class OtherUserProfileImageView extends StatelessWidget {
  final String profileImage;
  final double dimensionImage;
  final double borderWeight;
  const OtherUserProfileImageView({
    super.key,
    required this.profileImage,
    required this.dimensionImage, required this.borderWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: dimensionImage,
      width: dimensionImage,
      decoration: BoxDecoration(
        gradient: LinearGradient(
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
