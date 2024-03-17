import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/user_image.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/linear_gradient_image.dart';

class UserHorizontalListView extends ConsumerWidget {
  const UserHorizontalListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersProvider);
    final currentUserId = ref.read(userProvider);

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
                      .where((user) => user.uid == currentUserId)
                      .map((currentUser) => UserImage(
                            userId: currentUser.uid,
                          ))
                      .toList(),
                  ...allUsers
                      .where((user) => user.uid != currentUserId)
                      .map((user) => LinearGradientImage(
                            userId: user.uid,
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
