import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/fit/ratio_image_controller.dart';

class RatioWidget extends ConsumerWidget {
  const RatioWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: ref
            .read(ratioFitProvider.notifier)
            .getRatio()
            .entries
            .map(
              (entry) => TextButton(
                  onPressed: () {
                    ref
                        .read(ratioFitProvider.notifier)
                        .entryRatioValue(ratio: entry.value);
                  },
                  child: Text(entry.key)),
            )
            .toList(),
      ),
    );
  }
}
