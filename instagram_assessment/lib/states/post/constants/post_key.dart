import 'package:flutter/foundation.dart';

@immutable 
class PostKey{
  static const userId = 'uid';
  static const postId = 'post_id';
  static const message = 'message';
  static const createAt = 'created_at';
  static const thumbnailUrl = 'thumbnail_url';
  static const fileUrl = 'file_url';
  static const fileType = 'file_type';
  static const fileName = 'file_name';
  static const aspectRatio = 'aspect_ratio';
  static const thumbnailStorageId = 'thumbnail_storage_id';
  static const originalFileStorageId = 'original_file_storage_id';

  static const comment = 'comment';
  static const likes = 'likes';
  static const responses = 'responses';

  const PostKey._();
}