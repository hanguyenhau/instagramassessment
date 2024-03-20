import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/features/user/presentation/view/detail/component/image/other_user_image.dart';

class ShowAllFollowings extends ConsumerWidget {
  final String? uDocumentId;
  const ShowAllFollowings({super.key, required this.uDocumentId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final followingStream = ref.watch(retrieveFollowingsProvider(uDocumentId));
    return followingStream.when(
      data: (following) {
        return following.isNotEmpty
            ? Container(
                height: Dimension.height120,
                margin: const EdgeInsets.only(left: 20),
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: following.map((follower) {
                    return Padding(
                      padding: const EdgeInsets.only(right: Dimension.width15),
                      child: OtherUserImage(
                        uid: follower.userId,
                      ),
                    );
                  }).toList(),
                ),
              )
            : const SizedBox();
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const SizedBox(),
    );
  }
}
