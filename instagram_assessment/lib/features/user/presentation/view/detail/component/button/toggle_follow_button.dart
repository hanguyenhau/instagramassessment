import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/data/follow_request.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/style/user_detail_style.dart';
import 'package:instagram_assessment/models/user.dart';

class ToggleFollowButton extends ConsumerWidget {
  final UserModel uInfo;
  const ToggleFollowButton({required this.uInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentInfo = ref.watch(currentUserProvider);
    final isFollowed = ref.watch(findFollowProvider(uInfo.documentId));
    return isFollowed.when(
      data: (follow) {
        if (follow.isEmpty) {
          return currentInfo.when(
            data: (cInfo) => TextButton(
              onPressed: () async {
                ref.read(
                  followingToProvider(
                    FollowRequest(uTarget: uInfo, uCurrent: cInfo),
                  ),
                );
              },
              child: UserDetailStyle.followButton,
            ),
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const SizedBox(),
          );
        } else {
          return currentInfo.when(
            data: (cInfo) => TextButton(
              onPressed: () async {
                ref.read(
                  unFollowingToProvider(
                    FollowRequest(uTarget: uInfo, uCurrent: cInfo),
                  ),
                );
              },
              child: UserDetailStyle.unFollowButton,
            ),
            error: (error, stackTrace) => const Text('Error'),
            loading: () => const SizedBox(),
          );
        }
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const SizedBox(),
    );
    
  }
}
