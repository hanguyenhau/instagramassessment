import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';

class LikeTotalAndLastUser extends ConsumerWidget {
  final int totalLike;
  final PostId postId;
  const LikeTotalAndLastUser(
      {required this.postId, super.key, required this.totalLike});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allLikes = ref.watch(allLikePostProvider(postId));
    final likeRemaining = totalLike - 1;

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(
        children: [
          TextSpan(
            text: TextMessage.likedBy,
            style: TextStyle(color: AppColor.callToActionText),
          ),
          allLikes.when(
            data: (like) {
              if (like.isEmpty) {
                return const TextSpan();
              }
              final user = ref.watch(userByIdProvider(like.last.userId));
              return user.when(
                data: (userDetails) {
                  final currentUserId = ref.watch(userProvider);
                  final isCurrentUserLiked = like.last.userId == currentUserId;
                  final result =
                      isCurrentUserLiked ? TextMessage.you : userDetails.name;

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
