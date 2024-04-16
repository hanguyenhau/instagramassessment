import 'package:flutter_riverpod/flutter_riverpod.dart';

final cropProvider = StateNotifierProvider<CropImageController, double>(
  (ref) => CropImageController(),
);

class CropImageController extends StateNotifier<double> {
  CropImageController() : super(1.0);  
}
