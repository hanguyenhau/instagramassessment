import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/thumbnail_request.dart';

class ThumbnailPostImage extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const ThumbnailPostImage({
    super.key,
    required this.thumbnailRequest,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thumbnail = ref.watch(thumbnailProvider(thumbnailRequest));
    return thumbnail.when(
      data: (imageWithAspectRatio) => AspectRatio(
        aspectRatio: imageWithAspectRatio.aspectRatio,
        child: imageWithAspectRatio.image,
      ),
      error: (error, stackTrace) => Container(),
      loading: () => const SizedBox(),
    );
  }
}
