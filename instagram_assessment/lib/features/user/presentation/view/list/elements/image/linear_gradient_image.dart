import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/styles/user_image_styles.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:routemaster/routemaster.dart';

class LinearGradientImage extends ConsumerWidget {
  final UserId userId;
  const LinearGradientImage({
    super.key,
    required this.userId,
  });

  void _navigateToUserDetail(BuildContext context, String uid) =>
      Routemaster.of(context).push('/u/$uid');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userByIdProvider(userId));
    return userInfo.when(
      data: (user) => Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: Dimension.height75,
                width: Dimension.height75,
                decoration: UserImageStyles.linearGradientDecoration,
                child: GestureDetector(
                  onTap: () => _navigateToUserDetail(context, user.uid),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimension.borderWeight3),
                    child: Container(
                      decoration: UserImageStyles.imageDecoration,
                      child: ClipOval(
                          child: Image.network(
                        user.image,
                        fit: BoxFit.cover,
                      )),
                    ),
                  ),
                )),
            const SizedBox(
              height: Dimension.height5,
            ),
            Text(
              user.name,
              style: const TextStyle(fontSize: Dimension.fontSize12),
            )
          ],
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
