import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';

final userNameProvider = Provider.family.autoDispose<String?, UserId>(
  (ref, UserId userId) {
    final userInfo = ref.read(userProvider(userId));

    return userInfo.maybeWhen(
        data: (userInfo) => userInfo.displayName, orElse: () => null);
  },
);
