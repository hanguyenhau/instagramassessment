import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/model/picker_type.dart';

final adjustProvider =
    StateNotifierProvider<AdjustImageController, Map<Adjust, double>>(
  (ref) => AdjustImageController(ref: ref),
);

final colorFilterGeneratorProvider =
    StateNotifierProvider<ColorFilterGeneratorController, ColorFilterGenerator>(
  (ref) => ColorFilterGeneratorController(ref: ref),
);

class AdjustImageController extends StateNotifier<Map<Adjust, double>> {
  final Ref _ref;
  AdjustImageController({required Ref ref})
      : _ref = ref,
        super({
          Adjust.brightness: 0.0,
          Adjust.contrast: 0.0,
          Adjust.saturation: 0.0,
          Adjust.hue: 0.0,
          Adjust.sepia: 0.0,
        });

  void updateAdjustment({required Adjust adjust, required double value}) {
    state[adjust] = value;
    //for updated ColorFilterGenerator
    _ref.read(colorFilterGeneratorProvider.notifier).updateColorFilter();
  }

  void resetAdjustments() {
    state = {
      Adjust.brightness: 0.0,
      Adjust.contrast: 0.0,
      Adjust.saturation: 0.0,
      Adjust.hue: 0.0,
      Adjust.sepia: 0.0,
    };
    //for updated ColorFilterGenerator
    _ref.read(colorFilterGeneratorProvider.notifier).updateColorFilter();
  }
}

class ColorFilterGeneratorController
    extends StateNotifier<ColorFilterGenerator> {
  final Ref _ref;
  ColorFilterGeneratorController({required Ref ref})
      : _ref = ref,
        super(ColorFilterGenerator(name: 'Adjust', filters: [
          ColorFilterAddons.brightness(0.0),
          ColorFilterAddons.contrast(0.0),
          ColorFilterAddons.saturation(0.0),
          ColorFilterAddons.hue(0.0),
          ColorFilterAddons.sepia(0.0),
        ]));

  void updateColorFilter() {
    final adjustValue = _ref.watch(adjustProvider);
    state = ColorFilterGenerator(name: 'Adjust', filters: [
      ColorFilterAddons.brightness(adjustValue[Adjust.brightness] ?? 0.0),
      ColorFilterAddons.contrast(adjustValue[Adjust.contrast] ?? 0.0),
      ColorFilterAddons.saturation(adjustValue[Adjust.saturation] ?? 0.0),
      ColorFilterAddons.hue(adjustValue[Adjust.hue] ?? 0.0),
      ColorFilterAddons.sepia(adjustValue[Adjust.sepia] ?? 0.0),
    ]);
  }
}
