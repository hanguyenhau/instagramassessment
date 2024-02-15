import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/user_infor/models/user.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';

final userDetailInfoProvider = Provider.family.autoDispose<User?, UserId>(
  (ref, UserId userId) {
    final userInfo = ref.watch(userProvider(userId));

    return userInfo.maybeWhen(
        data: (userInfo) => userInfo, orElse: () => null);
  },
);
