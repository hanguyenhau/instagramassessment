import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/upload_image/extensions/get_image_aspect_ratio.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/upload_image/models/image_with_aspect_ratio.dart';
import 'package:instagram_assessment/states/upload_image/models/thumbnail_request.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest thumbnailRequest) async {
  final Image image;
  switch (thumbnailRequest.fileType) {
    case FileType.image:
      image = Image.file(
        thumbnailRequest.fileToPost,
        fit: BoxFit.fitHeight,
      );
      break;

    case FileType.video:
      image = Image.file(
        thumbnailRequest.fileToPost,
        fit: BoxFit.fitHeight,
      );
      break;
  }

  final aspectRatio = await image.getImageAspecRatio();

  return ImageWithAspectRatio(
    image: image,
    aspectRatio: aspectRatio,
  );
  
});
