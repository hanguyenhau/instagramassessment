import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleCommentsNotifier extends StateNotifier<bool> {
  ToggleCommentsNotifier() : super(true);

  void toggleShowMore() {
    state = !state;
  }
}
