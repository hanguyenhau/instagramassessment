import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class ObjectOtherTile extends StatelessWidget {
  const ObjectOtherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        TextMessage.object,
      ),
      leading: const FaIcon(FontAwesomeIcons.eye),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.chevron_right_outlined,
        ),
      ),
    );
  }
}
