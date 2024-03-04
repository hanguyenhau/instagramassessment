

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/post/presentation/like/like_total_and_last_user.dart';

class LikeDetailsText extends ConsumerWidget {
  final PostId postId;
  const LikeDetailsText({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allLikes = ref.watch(
      allLikePostProvider(postId),
    );
    return allLikes.when(
      data: (like) {
        if (like.isEmpty) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: Dimension.width20,
            right: Dimension.width20,
          ),
          child: LikeTotalAndLastUser(totalLike: like.length, postId: postId),
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
