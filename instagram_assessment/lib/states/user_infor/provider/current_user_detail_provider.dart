import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/controller/auth_controller.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';

final currentUserDetailProvider = Provider.autoDispose<UserModel?>(
  (ref) {
    final currentUserId = ref.watch(userProvider)?.userId;
    if (currentUserId == null) {
      return null;
    }
    final userInfo = ref.read(userWithIdProvider(currentUserId));

    return userInfo.maybeWhen(data: (userInfo) => userInfo, orElse: () => null);
  },
);
