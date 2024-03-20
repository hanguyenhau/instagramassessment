import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/data/follow_request.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/style/user_detail_style.dart';
import 'package:instagram_assessment/models/follow.dart';
import 'package:instagram_assessment/models/user.dart';

class ToggleFollowButton extends ConsumerWidget {
  final UserModel uInfo;
  const ToggleFollowButton({required this.uInfo, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentInfo = ref.watch(currentUserProvider);
    final isFollowed = ref.watch(findFollowProvider(uInfo.documentId));
    return isFollowed.when(
      data: (follow) => currentInfo.when(
        data: (info) => TextButton(
          onPressed: _onPress(currentInfo: info, follows: follow, ref: ref),
          child: _buttonChild(
            follows: follow,
          ),
        ),
        error: (_, __) => const Text('Error'),
        loading: () => const SizedBox(),
      ),
      error: (_, __) => const Text('Error'),
      loading: () => const SizedBox(),
    );
  }

  VoidCallback _onPress(
      {required Iterable<Follow> follows,
      required WidgetRef ref,
      required UserModel currentInfo}) {
    return follows.isEmpty
        ? () async {
            ref.read(
              followingToProvider(
                FollowRequest(uTarget: uInfo, uCurrent: currentInfo),
              ),
            );
          }
        : () async {
            ref.read(
              unFollowingToProvider(
                FollowRequest(uTarget: uInfo, uCurrent: currentInfo),
              ),
            );
          };
  }

  Widget _buttonChild({required Iterable<Follow> follows}) => follows.isEmpty
      ? UserDetailStyle.followButton
      : UserDetailStyle.unFollowButton;
}
