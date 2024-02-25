import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/controller/auth_controller.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';

final hasLikeResponseProvider = Provider.family.autoDispose<bool, Response>(
  (ref, Response response) {
    final currentUserId = ref.watch(userProvider)?.userId;

    final likes = response.likes;

    final hasLike = likes.any((element) => element.userId == currentUserId);

    return hasLike;
  },
);
