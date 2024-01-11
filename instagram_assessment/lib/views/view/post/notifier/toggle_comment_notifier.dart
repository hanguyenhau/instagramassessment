import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToggleCommentsNotifier extends StateNotifier<bool> {
  ToggleCommentsNotifier() : super(false);

  void toggleShowMore() {
    state = !state;
  }
}
