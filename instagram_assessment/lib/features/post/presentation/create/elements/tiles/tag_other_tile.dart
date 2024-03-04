import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class TagOtherTile extends StatelessWidget {
  const TagOtherTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text(
        TextMessage.tagOthers,
      ),
      leading: Image.asset(
        AssetsPath.personalButton,
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.chevron_right_outlined,
        ),
      ),
    );
  }
}
