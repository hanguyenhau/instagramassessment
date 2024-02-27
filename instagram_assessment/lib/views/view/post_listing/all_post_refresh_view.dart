import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/post/provider/all_posts_provider.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/config/core/animations/empty_contents_with_text_animation_view.dart';
import 'package:instagram_assessment/config/core/animations/error_animation_view.dart';
import 'package:instagram_assessment/config/core/animations/loading_animation_view.dart';
import 'package:instagram_assessment/views/view/post/post_details_view.dart';

class AllPostRefreshView extends ConsumerWidget {
  const AllPostRefreshView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);
    
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(
          const Duration(seconds: 1),
        );
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: TextMessage.noPostsAvailable,
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts.elementAt(index);
                return PostDetailsView(
                  post: post,
                );
              },
            );
          }
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
