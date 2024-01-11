import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';
import 'package:instagram_assessment/views/view/home/post/post_main_view.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/user_horizontal_view.dart';
import 'package:instagram_assessment/views/view/login/stateless_widget_view/horizontal_divider_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.scale(
          scale: Dimension.scale0dot6,
          child: Image.asset(
            AssetsPath.instagram,
            fit: BoxFit.cover,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: const <Widget>[
          ElevatedButtonView(
            iconName: AssetsPath.addButton,
            padding: 10,
          ),
          ElevatedButtonView(
            iconName: AssetsPath.favoriteButton,
            padding: 10,
          ),
          ElevatedButtonView(
            iconName: AssetsPath.messageButton,
            padding: 10,
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHorizontalView(),
            HorizontalDevider(),
            PostMainView(),
          ],
        ),
      ),
    );
  }
}
