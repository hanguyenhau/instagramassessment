import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/config/views/view/elevated_button_view.dart';
import 'package:instagram_assessment/features/user/presentation/user/grid_view_user_image.dart';
import 'package:instagram_assessment/features/user/presentation/user/user_detail_view.dart';
import 'package:instagram_assessment/features/user/presentation/user/user_favorite_activities_listview.dart';

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
        length: Dimension.tabLengthDefault,
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
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
                                    left: Dimension.height60,
                                    right: Dimension.width60,
                                    top: Dimension.height5,
                                    bottom: Dimension.height5),
                                decoration: BoxDecoration(
                                  color: AppColor.facebookColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      Dimension.circular10,
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  TextMessage.follow,
                                  style: TextStyle(
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              )),
                          TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: const EdgeInsets.only(
                                    left: Dimension.width60,
                                    right: Dimension.width60,
                                    top: Dimension.height5,
                                    bottom: Dimension.height5),
                                decoration: BoxDecoration(
                                  color: AppColor.callToActionButton,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(Dimension.circular10),
                                  ),
                                ),
                                child: const Text(
                                  TextMessage.message,
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
