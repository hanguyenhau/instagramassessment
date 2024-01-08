import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/constants/views/text_messages.dart';

class FacebookButtonView extends StatelessWidget {
  const FacebookButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: Dimension.height30,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.facebook,
          ),
          SizedBox(
            width: Dimension.width10,
          ),
          Text(
            TextMessage.continueWithFacebook,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }
}
