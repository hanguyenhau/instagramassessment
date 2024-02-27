import 'package:flutter/material.dart';

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
