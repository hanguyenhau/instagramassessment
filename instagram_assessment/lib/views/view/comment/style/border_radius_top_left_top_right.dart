import 'package:flutter/material.dart';

class BorderRadiusTopLeftTopRight {
  static BorderRadiusGeometry get rounded => const BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      );
}
