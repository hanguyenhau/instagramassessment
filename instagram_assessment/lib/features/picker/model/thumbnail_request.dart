
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';

@immutable
class ThumbnailRequest {
  final Uint8List fileToPost;
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
