import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/config/views/divider/horizontal_divider_view.dart';

class AppBarComment extends StatelessWidget {
  const AppBarComment({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
        title: Center(
          child: Padding(
            padding: EdgeInsets.only(top: Dimension.height10),
            child: Text(
              TextMessage.comments,
              style: TextStyle(
                fontSize: Dimension.fontSize15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        subtitle: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: HorizontalDevider(),
        ));
  }
}
