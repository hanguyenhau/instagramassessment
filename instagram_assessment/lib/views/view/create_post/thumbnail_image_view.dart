import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/upload_image/models/thumbnail_request.dart';
import 'package:instagram_assessment/states/upload_image/provider/thumbnail_provider.dart';

class ThumbnailImageView extends ConsumerWidget {
  final ThumbnailRequest thumbnailRequest;

  const ThumbnailImageView({
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
