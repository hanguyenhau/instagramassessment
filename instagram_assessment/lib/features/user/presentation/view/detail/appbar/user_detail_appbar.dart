import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class UserDetailAppbar extends StatelessWidget {
  final String name;
  const UserDetailAppbar({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: Dimension.height50,
      floating: false,
      backgroundColor: Colors.white,
      elevation: Dimension.elevation0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: AppColor.whiteColor,
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.keyboard_arrow_left),
        onPressed: () {
          // Handle back button press
          Navigator.pop(context);
        },
      ),
      title: Text(name),
      actions: [
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
