import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';

final hasLikeCommentProvider = Provider.family.autoDispose<bool, Comment>(
  (ref, Comment comment) {
    final currentUserId = ref.watch(userIdProvider);

    final likes = comment.likes;

    final hasLike = likes.any((element) => element.userId == currentUserId);

    return hasLike;
  },
);
