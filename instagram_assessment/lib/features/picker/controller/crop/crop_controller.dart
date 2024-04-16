import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cropProvider = StateNotifierProvider.autoDispose<CropImageController, CropController>(
  (ref) => CropImageController(),
);

class CropImageController extends StateNotifier<CropController> {
  CropImageController()
      : super(CropController(
          aspectRatio: 1,
          defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
        ));

  Map<double, String> cropLists() => {
        1.0: '1:1',
        2.0: '2:1',
        1 / 2: '1:2',
        4 / 3: '4:3',
        3 / 4: '3:4',
        16 / 9: '16:9',
        9 / 16: '9:16',
      };

  @override
  void dispose() {
    super.dispose();
    state.dispose(); //
  }
}
