import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/upload_image/helpers/image_picker_helper.dart';

class ImagePickerNotifier extends StateNotifier<bool> {
  ImagePickerNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<File?> getFile() async {
    isLoading = true;
    try {
      final imageFile = await ImagePickerHelper.pickImageFromGallery();
      if (imageFile == null) {
        isLoading = false;
        return null;
      }
      return imageFile;
    } catch (e) {
      isLoading = false;
      return null;
    } finally {
      isLoading = false;
    }
  }
}
