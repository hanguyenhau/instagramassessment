import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/like/provider/like_total_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/post/styles/liked_by_text_view.dart';

class LikeTotalAndUserInfoText extends ConsumerWidget {
  final PostId postId;
  const LikeTotalAndUserInfoText({required this.postId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalLikeRequest = ref.watch(
      likeTotalProvider(postId),
    );
    log('totalLikeRequest: $totalLikeRequest');
    return totalLikeRequest != null
        ? Padding(
            padding: const EdgeInsets.only(
              left: Dimension.width20,
              right: Dimension.width20,
            ),
            child: LikedByTextView(totalLikeRequest: totalLikeRequest),
          )
        : const SizedBox();
  }
}
