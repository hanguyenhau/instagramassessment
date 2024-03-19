import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Consumer(builder: (context, ref, child) {
                  final posts = ref.watch(
                    retrieveUserPostProvider(user.uid),
                  );

                  return posts.when(
                    data: (post) => Text(
                      post.length.toString(),
                      style: const TextStyle(
                        fontSize: Dimension.fontSize15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    error: (error, stackTrace) => const Text('Error'),
                    loading: () =>  const SizedBox(),
                  );
                }),
                const Text(
                  TextMessage.posts,
                  style: TextStyle(
                    fontSize: Dimension.fontSize12,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Consumer(builder: (context, ref, child) {
                  final followers = ref.watch(
                    getFollowersProvider(user.documentId),
                  );

                  return followers.when(
                    data: (followStream) => Text(
                      followStream.length.toString(),
                      style: const TextStyle(
                        fontSize: Dimension.fontSize15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    error: (error, stackTrace) => const Text('Error'),
                    loading: () =>  const SizedBox(),
                  );
                }),
                const Text(
                  TextMessage.followers,
                  style: TextStyle(
                    fontSize: Dimension.fontSize12,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Consumer(builder: (context, ref, child) {
                  final followers = ref.watch(
                    getFollowingsProvider(user.documentId),
                  );

                  return followers.when(
                    data: (followStream) => Text(
                      followStream.length.toString(),
                      style: const TextStyle(
                        fontSize: Dimension.fontSize15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    error: (error, stackTrace) => const Text('Error'),
                    loading: () => const SizedBox(),
                  );
                }),
                const Text(
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
      loading: () => const SizedBox(),
    );
  }
}
