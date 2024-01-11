import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';
import 'package:instagram_assessment/views/view/home/stateless_widget_view/user_horizontal_view.dart';
import 'package:instagram_assessment/views/view/post/post_main_view.dart';
import 'package:instagram_assessment/views/view/user/stateless_widget_view/favorite_list_view.dart';
import 'package:instagram_assessment/views/view/user/stateless_widget_view/user_detail_view.dart';

class UserMainView extends StatefulWidget {
  const UserMainView({super.key});

  @override
  State<UserMainView> createState() => _UserMainViewState();
}

class _UserMainViewState extends State<UserMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            backgroundColor: Colors.white,
            elevation: 0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
            title: const Text('Hello'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          // Add other slivers or widgets here for the scrolling content\
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const UserDetailView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: AppColor.facebookColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(
                              color: AppColor.whiteColor,
                            ),
                          ),
                        )),
                    TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 60, right: 60, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                            color: AppColor.callToActionButton,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: const Text(
                            'Message',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColor.callToActionButton,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: const ElevatedButtonView(
                          iconName: AssetsPath.addFriendButton,
                        ),
                      ),
                    ),
                  ],
                ),
                const FavoriteListView(),
              ],
            ),
          ),
          SliverAppBar(
            expandedHeight: 50.0,
            floating: false,
            backgroundColor: Colors.white,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Colors.white,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_left),
              onPressed: () {
                // Handle back button press
                Navigator.pop(context);
              },
            ),
            title: const Text('Hello'),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          // Add other slivers or widgets here for the scrolling content
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}
