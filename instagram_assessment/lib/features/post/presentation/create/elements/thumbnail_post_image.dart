import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/picker/model/thumbnail_request.dart';

class ThumbnailPostImage extends ConsumerWidget {
  final FileType fileType;

  const ThumbnailPostImage({
    super.key,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final thumbnailRequest = ThumbnailRequest(
        fileToPost: ref.watch(imagePickerProvider)!, fileType: fileType);
    final thumbnail = ref.watch(thumbnailAspectRatioProvider(thumbnailRequest));
    return thumbnail.when(
      data: (imageWithAspectRatio) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: AspectRatio(
          aspectRatio: imageWithAspectRatio.aspectRatio,
          child: imageWithAspectRatio.image,
        ),
      ),
      error: (error, stackTrace) => Container(),
      loading: () => const SizedBox(),
    );
  }
}
