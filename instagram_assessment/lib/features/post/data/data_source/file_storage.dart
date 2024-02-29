import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/models/typedef.dart';

final fileStorageProvider = Provider(
  (ref) => FileStorage(
    storage: ref.read(storageProvider),
  ),
);

@immutable
class FileStorage {
  final FirebaseStorage _storage;

  const FileStorage({required FirebaseStorage storage}) : _storage = storage;

  Future<String> saveThumbnail(
      {required UserId userId,
      required String fileName,
      required Uint8List thumbnailUint8List}) async {
    final thumbnailRef = getThumbnailRef(userId: userId, fileName: fileName);
    final thumbnailUploadTask = await thumbnailRef.putData(thumbnailUint8List);
    return thumbnailUploadTask.ref.name;
  }

  Future<String> saveOriginal(
      {required UserId userId,
      required String fileName,
      required String fileType,
      required File file}) async {
    final originalFileRef =
        getOriginalRef(userId: userId, fileName: fileName, fileType: fileType);
    final originalFileUploadTask = await originalFileRef.putFile(file);
    return originalFileUploadTask.ref.name;
  }

  Reference getThumbnailRef(
      {required UserId userId, required String fileName}) {
    return _storage
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);
  }

  Reference getOriginalRef(
      {required UserId userId,
      required String fileName,
      required String fileType}) {
    return _storage.ref().child(userId).child(fileType).child(fileName);
  }
}
