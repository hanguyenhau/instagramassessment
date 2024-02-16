import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';

final hasLikeResponseProvider = Provider.family.autoDispose<bool, Response>(
  (ref, Response response) {
    final currentUserId = ref.watch(userIdProvider);

    final likes = response.likes;

    final hasLike = likes.any((element) => element.userId == currentUserId);

    return hasLike;
  },
);
