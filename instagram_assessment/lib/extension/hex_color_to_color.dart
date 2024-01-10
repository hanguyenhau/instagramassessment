import 'package:flutter/material.dart';

extension HexColorToColor on String{
  Color convertHexColorToColor(){
    String currentColor = this.replaceAll('#', '');
    if(currentColor.length == 6){
      currentColor = '0xff$currentColor';
    }
    return Color(int.parse(currentColor),);
  }
}