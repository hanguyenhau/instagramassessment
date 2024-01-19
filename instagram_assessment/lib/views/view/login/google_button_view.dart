import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class GoogleButtonView extends StatelessWidget {
  const GoogleButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Dimension.height30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.google,
          ),
          SizedBox(
            width: Dimension.width10,
          ),
          Text(
            TextMessage.continueWithGoogle,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
