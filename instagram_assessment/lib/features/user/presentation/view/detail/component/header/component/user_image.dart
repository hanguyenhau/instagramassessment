import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/styles/user_image_styles.dart';

class UserImage extends StatelessWidget {
  final String image;
  const UserImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: UserImageStyles.paddingRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: Dimension.height75,
            width: Dimension.width75,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipOval(
                      child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
                ),
                UserImageStyles.addButton,
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
