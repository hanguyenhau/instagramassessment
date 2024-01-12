import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/views/util/view/elevated_button_view.dart';
import 'package:instagram_assessment/views/view/user/stateless_widget_view/grid_view_user_image.dart';
import 'package:instagram_assessment/views/view/user/stateless_widget_view/user_favorite_activities_listview.dart';
import 'package:instagram_assessment/views/view/user/stateless_widget_view/user_detail_view.dart';

class UserDetailsMainView extends StatefulWidget {
  const UserDetailsMainView({super.key});

  @override
  State<UserDetailsMainView> createState() => _UserMainViewState();
}

class _UserMainViewState extends State<UserDetailsMainView> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
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
                      const UserFavoriteActivitiesListView(),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      tabs: [
                        Tab(child: Image.asset(AssetsPath.exportMenuButton)),
                        Tab(child: Image.asset(AssetsPath.reelVideoButton)),
                        Tab(child: Image.asset(AssetsPath.personalButton)),
                      ],
                    ),
                  ),
                  pinned: true,
                )
              ];
            },
            body: Container(
              color: Colors.white,
              child: TabBarView(
                children: [
                  GridViewUserImages(),
                  GridViewUserImages(),
                  GridViewUserImages(),
                ],
              ),
            )),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
