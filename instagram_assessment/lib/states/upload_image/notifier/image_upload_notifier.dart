import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/upload_image/constants/constants.dart';
import 'package:instagram_assessment/states/upload_image/exception/could_not_build_thumbnail_exception.dart';
import 'package:instagram_assessment/states/upload_image/extensions/get_collection_file_type_name.dart';
import 'package:instagram_assessment/states/upload_image/extensions/get_image_data_aspect_ratio.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/post/models/post_payload.dart';
import 'package:uuid/uuid.dart';

class ImageUploadNotifier extends StateNotifier<bool> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType filetype,
    required String messenger,
    required UserId userId,
  }) async {
    isLoading = true;

    late Uint8List thumbnailUint8List;
    switch (filetype) {
      //Type Image
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }

        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumbnailWidth,
        );

        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;

      case FileType.video:
        break;
    }

    final thumbnailAspectRatio =
        await thumbnailUint8List.getImageDataAspectRatio();

    //reference name
    final fileName = const Uuid().v4();

    //thumbnail ref
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    //original ref
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(filetype.getCollectionFileTypeName())
        .child(fileName);

    try {
      //put thumbnail to Firebase Storage
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);

      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      //put original to Firebase Storage
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;

      final postPayLoad = PostPayLoad(
        userId: userId,
        message: messenger,
        thumbnailUrl: await thumbnailRef.getDownloadURL(),
        fileUrl: await originalFileRef.getDownloadURL(),
        fileType: filetype,
        fileName: fileName,
        aspectRatio: thumbnailAspectRatio,
        thumbnailStorageId: thumbnailStorageId,
        originalFileStorageId: originalFileStorageId,
      );

      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayLoad);

      return true;
    } catch (e) {
      return false;
    } finally{
      isLoading = false;
    }
  }
}
