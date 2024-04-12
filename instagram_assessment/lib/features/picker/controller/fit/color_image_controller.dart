import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final colorFitProvider = StateNotifierProvider<ColorImageController, Color>(
  (ref) => ColorImageController(),
);

class ColorImageController extends StateNotifier<Color> {
  ColorImageController() : super(Colors.white);

  void updateColor({required Color value}) => state = value;
}