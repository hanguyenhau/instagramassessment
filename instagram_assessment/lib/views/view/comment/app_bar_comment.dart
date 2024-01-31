import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';

class AppBarComment extends StatelessWidget {
  const AppBarComment({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          'Comments',
          style: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: HorizontalDevider(),
      ),
    );
  }
}
