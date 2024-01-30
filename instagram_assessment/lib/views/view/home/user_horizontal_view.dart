import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_assessment/states/user_infor/provider/all_users_provider.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/home/other_user_image.dart';

import 'package:instagram_assessment/views/view/home/current_user_image.dart';

class UserHorizontalView extends ConsumerWidget {
  const UserHorizontalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(allUsersProvider);
    final currentUserId = ref.read(authStateProvider).userid;

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
              children: allUsers.map((user) {
                return Padding(
                  padding: const EdgeInsets.only(right: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      user.userId == currentUserId
                          ? CurrentUserImage(
                              profileImage: user.image,
                            )
                          : OtherUserImage(
                              profileImage: user.image,
                            ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      const Text(TextMessage.yourStory),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
        error: (error, stackTrace) => const Text('Error'),
        loading: () => const Text('IsLoading'),
      ),
    );
  }
}
