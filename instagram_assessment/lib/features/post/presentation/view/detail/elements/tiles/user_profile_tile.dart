import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/other_user_image_test.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class UserProfileTile extends ConsumerWidget {
  final UserId userId;

  const UserProfileTile({required this.userId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userByIdProvider(userId));
    return userInfo.when(
      data: (user) {
        return ListTile(
          leading: OtherUserImageTest(
            profileImage: user.image,
            dimension: Dimension.height50,
            borderWeight: Dimension.borderWeight2,
          ),
          title: Text(
            user.name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
