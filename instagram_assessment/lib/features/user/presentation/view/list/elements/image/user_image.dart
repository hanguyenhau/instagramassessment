
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/elements/image/styles/user_image_styles.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:routemaster/routemaster.dart';

class UserImage extends ConsumerWidget {
  final UserId userId;
  final bool includeAddButton;

  const UserImage({
    super.key,
    required this.userId,
    this.includeAddButton = true,
  });

  void _navigateToUserDetail(BuildContext context, String uid) =>
      Routemaster.of(context).push('/u/$uid');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userByIdProvider(userId));
    return userInfo.when(
      data: (user) => Padding(
        padding: UserImageStyles.paddingRight,
        child: GestureDetector(
          onTap: () => _navigateToUserDetail(context, user.uid),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Dimension.height75,
                width: Dimension.width75,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipOval(
                          child: Image.network(
                        user.image,
                        fit: BoxFit.cover,
                      )),
                    ),
                    includeAddButton
                        ? UserImageStyles.addButton
                        : const SizedBox(),
                  ],
                ),
              ),
              const SizedBox(
                height: Dimension.height5,
              ),
              const Text(
                TextMessage.yourStory,
                style: TextStyle(fontSize: Dimension.fontSize12),
              ),
            ],
          ),
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const Text('Loading'),
    );
  }
}
