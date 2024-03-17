import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/header/component/user_image.dart';
import 'package:instagram_assessment/models/typedef.dart';

class UserInfoHeader extends ConsumerStatefulWidget {
  final UserId userId;
  const UserInfoHeader({super.key, required this.userId});

  @override
  ConsumerState<UserInfoHeader> createState() => _UserDetailViewState();
}

class _UserDetailViewState extends ConsumerState<UserInfoHeader> {
  @override
  Widget build(BuildContext context) {
    final userInfo = ref.watch(userByIdProvider(widget.userId));
    return userInfo.when(
      data: (user) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(Dimension.padding10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //image
                UserImage(image: user.image),
              ],
            ),
            const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '1000',
                  style: TextStyle(
                    fontSize: Dimension.fontSize15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TextMessage.posts,
                  style: TextStyle(
                    fontSize: Dimension.fontSize12,
                  ),
                )
              ],
            ),
            const Column(
              children: [
                Text(
                  '60',
                  style: TextStyle(
                    fontSize: Dimension.fontSize15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TextMessage.followers,
                  style: TextStyle(
                    fontSize: Dimension.fontSize12,
                  ),
                ),
              ],
            ),
            const Column(
              children: [
                Text(
                  '4',
                  style: TextStyle(
                    fontSize: Dimension.fontSize15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  TextMessage.following,
                  style: TextStyle(
                    fontSize: Dimension.fontSize12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
