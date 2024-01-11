import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';

class UserProfileImageView extends StatelessWidget {
  final String profileImage;
  const UserProfileImageView({super.key, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 75,
          width: 75,
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipOval(
                    child: Image.asset(
                  profileImage,
                  fit: BoxFit.cover,
                )),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      color: Colors.white),
                  child: const ElevatedButtonView(
                    iconName: AssetsPath.addStoryButton,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
