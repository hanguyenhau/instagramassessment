import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/like/provider/like_total_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/like/liked_by_text_view.dart';

class LikeTotalAndUserInfoText extends ConsumerWidget {
  final PostId postId;
  const LikeTotalAndUserInfoText({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalLikeRequest = ref.watch(
      likeTotalProvider(postId),
    );
    return totalLikeRequest.when(
      data: (totalLike) {
        if (totalLike <= 0) {
          return const SizedBox();
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: Dimension.width20,
            right: Dimension.width20,
          ),
          child: LikedByTextView(totalLike: totalLike, postId: postId),
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
