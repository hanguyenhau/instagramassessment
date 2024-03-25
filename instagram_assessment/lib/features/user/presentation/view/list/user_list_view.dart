import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/linear_gradient_image.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/user_image.dart';
import 'package:instagram_assessment/models/follow.dart';
import 'package:instagram_assessment/models/user.dart';

class UserHorizontalListView extends ConsumerWidget {
  const UserHorizontalListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userByIdProvider(ref.watch(userProvider)!)).when(
          data: (info) => _buildUserInfo(context, ref, info),
          error: (error, stackTrace) => const Text('Error'),
          loading: () => const SizedBox(),
        );
  }

  Widget _buildUserInfo(BuildContext context, WidgetRef ref, UserModel uInfo) {
    final followingStream =
        ref.watch(retrieveFollowingsProvider(uInfo.documentId));

    return RefreshIndicator(
      onRefresh: () async {
        ref.refresh(retrieveFollowingsProvider(uInfo.documentId));
      },
      child: followingStream.when(
        data: (followings) => _buildFollowingListView(followings, uInfo.uid),
        loading: () => const Text('IsLoading'),
        error: (error, stackTrace) => const Text('Error'),
      ),
    );
  }

  Widget _buildFollowingListView(Iterable<Follow> followings, String userId) {
    return Container(
      height: Dimension.height120,
      margin: const EdgeInsets.only(left: Dimension.width20),
      child: Row(
        children: [
          UserImage(userId: userId),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: followings.map((follower) {
                return Padding(
                  padding: const EdgeInsets.only(right: Dimension.width15),
                  child: LinearGradientImage(userId: follower.userId),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
