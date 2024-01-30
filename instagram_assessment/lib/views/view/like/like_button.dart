import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/like/models/like_request.dart';
import 'package:instagram_assessment/states/like/provider/like_dislike_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;

  const LikeButton({
    required this.postId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () {
        final userId = ref.read(userIdProvider);
        if (userId == null) {
          return;
        }
        final likeRequest = LikeRequest(likedBy: userId, postId: postId);
        final value = ref.read(likeDislikeProvider(likeRequest));
        log('Liked: $value');
      },
      child: Image.asset(
        AssetsPath.favoriteButton,
        width: Dimension.width26,
        height: Dimension.height26,
      ),
    );
  }
}
