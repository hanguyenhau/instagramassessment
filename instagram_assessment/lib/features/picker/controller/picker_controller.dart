import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/helper/image_picker_helper.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/picker/extension/get_image_aspect_ratio.dart';
import 'package:instagram_assessment/features/picker/model/image_with_aspect_ratio.dart';
import 'package:instagram_assessment/features/picker/model/thumbnail_request.dart';

final imagePickerProvider = StateNotifierProvider<ImagePickerController, Uint8List?>(
  (ref) => ImagePickerController(),
);

final thumbnailAspectRatioProvider = FutureProvider.family
    .autoDispose<ImageWithAspectRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest thumbnailRequest) async {
  final imagePickerController = ref.watch(imagePickerProvider.notifier);
  return imagePickerController.imageWithAspectRatio(thumbnailRequest);
});

class ImagePickerController extends StateNotifier<Uint8List ?> {
  ImagePickerController() : super(null);

  Future getFile() async {
    try {
      final imageFile = await ImagePickerHelper.pickImageFromGallery();
      if (imageFile == null) {
        state = null;
      }
      state = imageFile;
    } catch (e) {
      state = null;
    } 
  }

  Future<Uint8List?> getFileFromPicker() async {
    try {
      final imageFile = await ImagePickerHelper.pickImageFromGallery();
      if (imageFile == null) {
        return null;
      }
      return imageFile;
    } catch (e) {
      return null;
    } 
  }

  void updateFile(Uint8List? image) {
     state = image;
     if(image == state){
      log('message');
     }
  }

  Future<ImageWithAspectRatio> imageWithAspectRatio(
      ThumbnailRequest thumbnailRequest) async {
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
  }
}
