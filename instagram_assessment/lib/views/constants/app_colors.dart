
import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/extension/hex_color_to_color.dart';

@immutable 
class AppColor{
  static final facebookColor = '#1877F2'.convertHexColorToColor();
  static final dividerTextColor = '6D6D6D'.convertHexColorToColor();
  static final dividerColor = 'D3D3D3'.convertHexColorToColor();
  static const whiteColor = Colors.white;
  static final yellowLinear006 = 'FAF006'.convertHexColorToColor();
  static final yellowLinearC05 = 'FACC05'.convertHexColorToColor();
  static final redLinear858 = 'ED5858'.convertHexColorToColor();
  static final blueLinearDF4 = 'C39DF4'.convertHexColorToColor();
  static final callToActionText = '8A8A8A'.convertHexColorToColor();
  static final callToActionButton = 'DFDFDF'.convertHexColorToColor();
  static final borderFavorite = '7E7E7E'.convertHexColorToColor();

  const AppColor._();
}