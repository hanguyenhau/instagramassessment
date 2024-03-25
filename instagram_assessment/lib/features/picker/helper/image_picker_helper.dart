import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_assessment/config/core/extension/main_exception.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();

  static Future<File?> pickImageFromGallery() async =>
      await _imagePicker.pickImage(source: ImageSource.gallery).toFile();
}
