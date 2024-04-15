import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:image_picker/image_picker.dart';
import 'package:instagram_assessment/features/comment/data/model/date_sorting.dart';
import 'package:instagram_assessment/features/picker/extension/get_image_aspect_ratio.dart';
import 'package:path_provider/path_provider.dart';

class CouldNotBuildThumbnailException implements Exception {
  final message = "Could not build thumbnail";
  const CouldNotBuildThumbnailException();
}

extension DismissKeyBoard on Widget {
  void dismissKeyboard() => FocusManager.instance.primaryFocus?.unfocus();
}

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getImageDataAspectRatio() {
    final image = material.Image.memory(this);
    return image.getImageAspecRatio();
  }
}

extension ConvertHexColorToColor on String {
  Color convertHexColorToColor() {
    String currentColor = replaceAll('#', '');
    if (currentColor.length == 6) {
      currentColor = '0xff$currentColor';
    }
    return Color(
      int.parse(currentColor),
    );
  }
}

extension SortingByRequest on Iterable<dynamic> {
  Iterable<dynamic> applySortingFrom(DateSorting request) {
    final sortedDocument = toList()
      ..sort(
        (a, b) {
          switch (request) {
            case DateSorting.newestOnTop:
              return b.createAt.compareTo(a.createAt);

            case DateSorting.oldestOnTop:
              return a.createAt.compareTo(b.createAt);
          }
        },
      );
    return sortedDocument;
  }
}

extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then((value) => value?.path)
      .then((value) => value != null ? File(value) : null);
}

extension XfileToUint8 on Future<XFile?> {
  Future<Uint8List?> toUint8List() async => then((value) => value?.readAsBytes());
}

extension ImageToFile on Uint8List {
  Future<File> imageToFile() async {
    Directory tempDir = await getTemporaryDirectory();

    // Create a temporary file path
    String tempFilePath = '${tempDir.path}/temp_image.png';

    // Write the bytes to the file
    await File(tempFilePath).writeAsBytes(this);

    // Return the temporary File object
    return File(tempFilePath);
  }
}

extension Uint8ListToFile on Uint8List{
  Future<File> uint8ListToFile(String filePath) async {
    // Create a File object with the provided filePath
    final file = File(filePath);

    // Write the Uint8List data into the file
    await file.writeAsBytes(this);
    return file;
  }
}
