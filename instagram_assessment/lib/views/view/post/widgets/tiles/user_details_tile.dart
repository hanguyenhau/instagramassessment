import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/user_infor/provider/user_provider.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/user/horizontal/other_user_image.dart';

class UserDetailsTile extends ConsumerWidget {
  final UserId userId;

  const UserDetailsTile({required this.userId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userWithIdProvider(userId));
    return userInfo.when(
      data: (user) {
        return ListTile(
          leading: OtherUserImage(
            profileImage: user.image,
            dimension: Dimension.height50,
            borderWeight: Dimension.borderWeight2,
          ),
          title: Text(
            user.displayName,
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
