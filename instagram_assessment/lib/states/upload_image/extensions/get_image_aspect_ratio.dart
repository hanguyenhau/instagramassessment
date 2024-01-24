import 'dart:async';

import 'package:flutter/material.dart' as material;

extension GetImageAspectRatio on material.Image {
  Future<double> getImageAspecRatio() {
    final completer = Completer<double>();
    image
        .resolve(const material.ImageConfiguration())
        .addListener(material.ImageStreamListener((image, synchronousCall) {
      final aspectRatio = image.image.width / image.image.height;
      image.dispose();
      completer.complete(aspectRatio);
    }));
    return completer.future;
  }
}
