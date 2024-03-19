import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/appbar/user_detail_appbar.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/show_all_posts_grid_view.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/style/user_detail_style.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/header/user_info_header.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/show_all_follow_user.dart';
import 'package:instagram_assessment/models/typedef.dart';

class UserDetailsView extends ConsumerStatefulWidget {
  final UserId userId;
  const UserDetailsView({super.key, required this.userId});

  @override
  ConsumerState<UserDetailsView> createState() => _UserMainViewState();
}

class _UserMainViewState extends ConsumerState<UserDetailsView> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userByIdProvider(widget.userId));

    return userInfo.when(
      data: (user) => Scaffold(
        body: DefaultTabController(
          length: Dimension.tabLengthDefault,
          child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  UserDetailAppbar(name: user.name),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        UserInfoHeader(userId: widget.userId),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: () async {
                                  user.documentId != null
                                      ? ref.read(
                                          followingToProvider(user.documentId!))
                                      : null;
                                },
                                child: user.uid == ref.watch(userProvider)
                                    ? UserDetailStyle.editButton
                                    : UserDetailStyle.followButton),
                            TextButton(
                                onPressed: () {},
                                child: UserDetailStyle.messageButton),
                            user.uid == ref.watch(userProvider)
                                ? const SizedBox()
                                : TextButton(
                                    onPressed: () {},
                                    child: UserDetailStyle.addFollowButton,
                                  ),
                          ],
                        ),
                        const ShowAllFollowUser(),
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
                    ShowAllPostGridView(),
                    ShowAllPostGridView(),
                    ShowAllPostGridView(),
                  ],
                ),
              )),
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
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
      color: const Color.fromRGBO(255, 255, 255, 1),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
