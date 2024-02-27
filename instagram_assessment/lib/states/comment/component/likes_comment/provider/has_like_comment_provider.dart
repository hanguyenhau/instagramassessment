import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/comment.dart';

final hasLikeCommentProvider = Provider.family.autoDispose<bool, Comment>(
  (ref, Comment comment) {
    final currentUserId = ref.watch(userProvider);

    final likes = comment.likes;

    final hasLike = likes.any((element) => element.userId == currentUserId);

    return hasLike;
  },
);
