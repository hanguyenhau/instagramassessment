import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';

class CurrentUserImageWithAddButton extends StatelessWidget {
  final String profileImage;
  final bool includeAddButton;

  const CurrentUserImageWithAddButton({
    super.key,
    required this.profileImage,
    this.includeAddButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15,
      ),
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 75,
            width: 75,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ClipOval(
                      child: Image.network(
                    profileImage,
                    fit: BoxFit.cover,
                  )),
                ),
                includeAddButton
                    ? Positioned(
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
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Text(
            TextMessage.yourStory,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
