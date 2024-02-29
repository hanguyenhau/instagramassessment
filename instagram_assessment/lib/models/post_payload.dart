import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/post_key.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';

@immutable
class PostPayLoad extends MapView<String, dynamic> {
  PostPayLoad({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required FileType fileType,
    required String fileName,
    required double aspectRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
  }) : super({
          PostKey.userId: userId,
          PostKey.message: message,
          PostKey.createAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailUrl: thumbnailUrl,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileType.name,
          PostKey.fileName: fileName,
          PostKey.aspectRatio: aspectRatio,
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.originalFileStorageId: originalFileStorageId,
        });
}
