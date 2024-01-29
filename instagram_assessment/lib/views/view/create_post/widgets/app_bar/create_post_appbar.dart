import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class CreatePostAppbar extends AppBar {
  CreatePostAppbar({
    Key? key,
    required BuildContext context,
  }) : super(
          key: key,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.keyboard_arrow_left,
            ),
          ),
          flexibleSpace: const FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              TextMessage.createNewPost,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimension.fontSize15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
}
