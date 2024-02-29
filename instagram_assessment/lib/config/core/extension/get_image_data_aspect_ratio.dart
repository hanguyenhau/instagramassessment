import 'dart:typed_data';
import 'package:flutter/material.dart' as material;
import 'package:instagram_assessment/features/picker/extension/get_image_aspect_ratio.dart';

extension GetImageDataAspectRatio on Uint8List{
  Future<double> getImageDataAspectRatio(){
    final image = material.Image.memory(this);
    return image.getImageAspecRatio();
  }
}