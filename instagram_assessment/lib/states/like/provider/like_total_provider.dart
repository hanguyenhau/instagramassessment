import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/like/models/total_like_request.dart';
import 'package:instagram_assessment/states/like/provider/like_provider.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_detail_provider.dart';

final likeTotalProvider =
    Provider.family.autoDispose<TotalLikeRequest?, PostId>(
  (ref, PostId postId) {
    final likes = ref.watch(likeProvider(postId));
    final currentUserId = ref.watch(userIdProvider);

    return likes.when(
      data: (like) {
        if (like.isEmpty) {
          return null;
        }
        if (like.last.userId == currentUserId) {
          return TotalLikeRequest(likedBy: 'me', totalLike: like.length);
        }
        final userName = ref.watch(userNameProvider(like.last.userId));
        if (userName != null) {
          return TotalLikeRequest(likedBy: userName, totalLike: like.length);
        }
      },
      error: (error, stackTrace) => null,
      loading: () => null,
    );
  },
);
