import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/user_infor/models/user.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';

final currentUserDetailProvider = Provider.autoDispose<User?>(
  (ref) {
    final currentUserId = ref.watch(userIdProvider);
    if (currentUserId == null) {
      return null;
    }
    final userInfo = ref.read(userProvider(currentUserId));

    return userInfo.maybeWhen(data: (userInfo) => userInfo, orElse: () => null);
  },
);
