import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';

@immutable
class ThumbnailRequest {
  final File fileToPost;
  final FileType fileType;

  const ThumbnailRequest({
    required this.fileToPost,
    required this.fileType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailRequest &&
          runtimeType == other.runtimeType &&
          fileToPost == other.fileToPost &&
          fileType == other.fileType;

  @override
  int get hashCode => Object.hashAll(
        [
          runtimeType,
          fileToPost,
          fileType,
        ],
      );
}
