import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension ToFile on Future<XFile?>{
  Future<File?> toFile() => then((value) => value?.path)
        .then((value) => value != null ? File(value) : null);
}