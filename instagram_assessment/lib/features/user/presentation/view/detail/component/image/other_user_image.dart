import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';

class OtherUserImage extends ConsumerWidget {
  final UserId uid;

  const OtherUserImage({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userByIdProvider(uid));
    return userInfo.when(
      data: (info) => Padding(
        padding: const EdgeInsets.only(right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Dimension.height75,
              width: Dimension.width75,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.borderFavorite,
                    AppColor.borderFavorite,
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimension.borderWeight1),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: Dimension.width2dot2,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(Dimension.circular100),
                    ),
                  ),
                  child: ClipOval(
                      child: Image.network(
                    info.image,
                    fit: BoxFit.cover,
                  )),
                ),
              ),
            ),
            info.name.isNotEmpty
                ? const SizedBox(
                    height: 5.0,
                  )
                : const SizedBox(),
            info.name.isNotEmpty
                ? Text(
                    info.name,
                    style: const TextStyle(fontSize: 12),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const SizedBox(),
    );
  }
}
