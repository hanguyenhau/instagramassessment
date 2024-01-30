import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/all_users_provider.dart';
import 'package:instagram_assessment/views/view/user/horizontal/other_user_image.dart';

import 'package:instagram_assessment/views/view/user/horizontal/current_user_image.dart';

class UserHorizontalView extends ConsumerWidget {
  const UserHorizontalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersProvider);
    final currentUserId = ref.read(userIdProvider);

    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allUsersProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: users.when(
        data: (allUsers) {
          return Container(
            height: 120,
            margin: const EdgeInsets.only(left: 20),
            child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children:
                    //sort the users so that the one with user.userid == currentUser.id show first
                    [
                  ...allUsers
                      .where((user) => user.userId == currentUserId)
                      .map((currentUser) =>
                          CurrentUserImage(profileImage: currentUser.image))
                      .toList(),
                  ...allUsers
                      .where((user) => user.userId != currentUserId)
                      .map((user) => OtherUserImage(
                            profileImage: user.image,
                            userName: user.displayName,
                          ))
                ]),
          );
        },
        error: (error, stackTrace) => const Text('Error'),
        loading: () => const Text('IsLoading'),
      ),
    );
  }
}
