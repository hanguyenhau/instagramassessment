import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/animations/empty_contents_animation_view.dart';
class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.white54),
          ),
          // Lottie.asset(
          //   'assets/animation/empty.json',
          //   reverse: true,
          //   repeat: false,
          // ),
          const EmptyContentsAnimationView(),
        ],
      ),
    ));
  }
}
