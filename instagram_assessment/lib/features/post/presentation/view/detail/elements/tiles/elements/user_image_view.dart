import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class UserImageView extends ConsumerWidget {
  final String imageUrl;

  const UserImageView({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: Dimension.height50,
            width: Dimension.width50,
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
              padding: const EdgeInsets.all(Dimension.borderWeight2),
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
                  imageUrl,
                  fit: BoxFit.cover,
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
