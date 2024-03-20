import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';

class ShowAllPostGridView extends ConsumerWidget {
  final UserId uid;

  const ShowAllPostGridView({
    super.key,
    required this.uid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final streamPost = ref.watch(retrieveUserPostProvider(uid));
    return streamPost.when(
      data: (posts) {
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: Dimension.crossAxisCount,
            childAspectRatio: Dimension.childAspectRatio,
            crossAxisSpacing: Dimension.crossAxisSpacing,
            mainAxisExtent: Dimension.mainAxisExtent,
            mainAxisSpacing: Dimension.mainAxisSpacing,
          ),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return // Adjust the height as needed
                Image.network(
              posts.toList()[index].fileUrl,
              fit: BoxFit.cover,
            );
          },
        );
      },
      error: (error, stackTrace) => const Text('Error'),
      loading: () => const SizedBox(),
    );
  }
}
