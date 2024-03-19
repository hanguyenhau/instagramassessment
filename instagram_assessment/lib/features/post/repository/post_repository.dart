import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/extension/sorting_by_request.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';
import 'package:instagram_assessment/features/picker/extension/get_collection_file_type_name.dart';
import 'package:instagram_assessment/features/post/data/data_source/file_storage.dart';
import 'package:instagram_assessment/features/post/data/data_source/post_source.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/models/like.dart';
import 'package:instagram_assessment/models/like_payload.dart';
import 'package:instagram_assessment/models/post.dart';
import 'package:instagram_assessment/models/post_payload.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/extension/get_image_data_aspect_ratio.dart';
import 'package:uuid/uuid.dart';

final postRepositoryProvider = Provider(
  (ref) => PostRepository(
    postStorage: ref.watch(postStorageProvider),
    fileStorage: ref.watch(fileStorageProvider),
  ),
);

@immutable
class PostRepository {
  final PostStorage _postStorage;
  final FileStorage _fileStorage;

  const PostRepository(
      {required FileStorage fileStorage, required PostStorage postStorage})
      : _fileStorage = fileStorage,
        _postStorage = postStorage;

  Stream<Iterable<Post>> allPosts() => _postStorage.allPosts().map(
      (event) => event.applySortingFrom(DateSorting.newestOnTop) as dynamic);

  Future<bool> savePost({
    required UserId userId,
    required Uint8List thumbnailUint8List,
    required File file,
    required FileType filetype,
    required String messenger,
  }) async {
    try {
      final fileName = const Uuid().v4();

      final thumbnailAspectRatio =
          await thumbnailUint8List.getImageDataAspectRatio();

      final thumbnailStorageId = await _fileStorage.saveThumbnail(
          userId: userId,
          fileName: fileName,
          thumbnailUint8List: thumbnailUint8List);

      final originalFileStorageId = await _fileStorage.saveOriginal(
          userId: userId,
          fileName: fileName,
          fileType: filetype.getCollectionFileTypeName(),
          file: file);

      final thumbnailUrl = await _fileStorage
          .getThumbnailRef(userId: userId, fileName: fileName)
          .getDownloadURL();

      final originalUrl = await _fileStorage
          .getOriginalRef(
            userId: userId,
            fileName: fileName,
            fileType: filetype.getCollectionFileTypeName(),
          )
          .getDownloadURL();

      final payload = PostPayLoad(
        userId: userId,
        message: messenger,
        thumbnailUrl: thumbnailUrl,
        fileUrl: originalUrl,
        fileType: filetype,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
      );

      await _postStorage.savePost(payload);
      return true;
    } catch (e) {
      return false;
    }
  }

  Stream<Iterable<Like>> allLikePost(PostId postId) =>
      _postStorage.allLikePost(postId);

  Stream<Iterable<Post>> retrieveUserPost({required UserId userId}) =>
      _postStorage.retrieveUserPost(userId: userId);

  Stream<bool> hasLike({required UserId userId, required PostId postId}) =>
      _postStorage.hasLike(userId: userId, postId: postId);

  Future<void> likePost(
      {required UserId userId, required PostId postId}) async {
    final payload = LikePayLoad(
      userId: userId,
      postId: postId,
    );
    await _postStorage.likePost(payload);
  }

  Future<void> disLikePost(
          {required UserId userId, required PostId postId}) async =>
      await _postStorage.dislikePost(postId: postId, userId: userId);
}
