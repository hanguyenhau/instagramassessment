import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';

class OtherUserImage extends StatelessWidget {
  final String profileImage;
  final double dimension;
  final double borderWeight;
  final bool grayGradient;
  final String userName;

  const OtherUserImage({
    super.key,
    required this.profileImage,
    this.dimension = Dimension.height75,
    this.borderWeight = Dimension.borderWeight3,
    this.grayGradient = false,
    this.userName = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: dimension,
            width: dimension,
            decoration: BoxDecoration(
              gradient: grayGradient
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
                    child: Image.network(
                  profileImage,
                  fit: BoxFit.cover,
                )),
              ),
            ),
          ),
          userName.isNotEmpty
              ? const SizedBox(
                  height: 5.0,
                )
              : const SizedBox(),
          userName.isNotEmpty
              ? Text(
                  userName,
                  style: const TextStyle(fontSize: 12),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
