import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';

@immutable
class Post {
  final PostId postId;
  final UserId userId;
  final String message;
  final DateTime createAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;

  Post({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.timestamp(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        fileType = FileType.values.firstWhere(
          (fileType) => fileType.name == json[PostKey.fileType],
          orElse: () => FileType.image,
        ),
        fileName = json[PostKey.originalFileStorageId],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId];
}
