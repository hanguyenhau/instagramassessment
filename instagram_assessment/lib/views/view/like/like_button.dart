import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/like/models/like_request.dart';
import 'package:instagram_assessment/states/like/provider/has_like_provider.dart';
import 'package:instagram_assessment/states/like/provider/like_dislike_action_provider.dart';
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
    final hasLike = ref.watch(hasLikeProvider(postId));
    return hasLike.when(
      data: (hasLike) {
        return TextButton(
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            final likeRequest = LikeRequest(likedBy: userId, postId: postId);
            ref.watch(likeDislikeActionProvider(likeRequest));
          },
          child: hasLike
              ? Image.asset(
                  AssetsPath.hasFavoritedButton,
                  width: Dimension.height26,
                  height: Dimension.width26,
                )
              : Image.asset(
                  AssetsPath.favoriteButton,
                  width: Dimension.width26,
                  height: Dimension.height26,
                ),
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
