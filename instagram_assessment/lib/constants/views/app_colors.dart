import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/extension/hex_color_to_color.dart';

@immutable 

class AppColor{
  static final facebookColor = '#1877F2'.convertHexColorToColor();
  static const textWhiteColor = Colors.white;
  static final dividerTextColor = '6D6D6D'.convertHexColorToColor();
  static final dividerColor = 'D3D3D3'.convertHexColorToColor();

  const AppColor._();
}