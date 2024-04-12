import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratioFitProvider = StateNotifierProvider<RatioImageController, double>(
  (ref) => RatioImageController(),
);

class RatioImageController extends StateNotifier<double> {
  RatioImageController() : super(1.0);

  final Map<String, double> _ratios = {
    '1:1': 1 / 1,
    '1:2': 1 / 2,
    '2:1': 2 / 1,
    '4:3': 4 / 3,
    '3:4': 3 / 4,
    '16:9': 16 / 9,
    '9:16': 9 / 16,
  };

  Map<String, double> getRatio() => _ratios;

  void entryRatioValue({required double ratio}) => state = ratio;
}
