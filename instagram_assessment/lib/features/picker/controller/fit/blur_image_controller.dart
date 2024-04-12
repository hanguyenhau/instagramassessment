import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';

final blurFitProvider = StateNotifierProvider<BlurImageController, double>(
  (ref) => BlurImageController(),
);

final blurBackgroundProvider = StateNotifierProvider<BlurBackgroundController, Uint8List>(
  (ref) => BlurBackgroundController(ref: ref),
);

class BlurImageController extends StateNotifier<double> {
  BlurImageController() : super(0);

  void updateBlur({required double value}) => state = value;
}

class BlurBackgroundController extends StateNotifier<Uint8List> {
  BlurBackgroundController({
    required Ref ref,
  }) : super(ref.watch(imagePickerProvider)!);

  void updateBackground({required Uint8List image}) => state = image;
}
