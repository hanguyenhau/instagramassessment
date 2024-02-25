import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/controller/auth_controller.dart';
import 'package:instagram_assessment/states/like/provider/last_people_like_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';

class LikedByTextView extends ConsumerWidget {
  final int totalLike;
  final PostId postId;
  const LikedByTextView(
      {required this.postId, super.key, required this.totalLike});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastLiked = ref.watch(lastLikeLikeProvider(postId));
    final likeRemaining = totalLike - 1;

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          TextSpan(
            text: TextMessage.likedBy,
            style: TextStyle(color: AppColor.callToActionText),
          ),
          lastLiked.when(
            data: (lastUser) {
              if (lastUser == null) {
                return const TextSpan();
              }
              final user = ref.watch(userWithIdProvider(lastUser.userId));
              return user.when(
                data: (userDetails) {
                  final currentUserId = ref.watch(userProvider)?.userId;
                  final isCurrentUserLiked = lastUser.userId == currentUserId;
                  final result =
                      isCurrentUserLiked ? 'you' : userDetails.displayName;

                  return TextSpan(
                    text: ' $result',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                },
                error: (error, stackTrace) => const TextSpan(),
                loading: () => const TextSpan(),
              );
            },
            error: (error, stackTrace) => const TextSpan(),
            loading: () => const TextSpan(),
          ),
          likeRemaining > 0
              ? TextSpan(
                  text: ' ${TextMessage.and}',
                  style: TextStyle(color: AppColor.callToActionText),
                )
              : const TextSpan(),
          likeRemaining > 0
              ? TextSpan(
                  text: ' $likeRemaining ${TextMessage.others}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )
              : const TextSpan(),
        ],
      ),
    );
  }
}
