import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;

  const LikeButton({
    required this.postId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLike = ref.watch(hasLikePostProvider(postId));

    return hasLike.when(
      data: (hasLike) {
        return TextButton(
          onPressed: () {
            hasLike
                ? ref.read(disLikePostProvider(postId))
                : ref.read(likePostProvider(postId));
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
