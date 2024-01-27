import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/upload_image/notifier/image_picker_notifier.dart';

final imagePickerProvider = StateNotifierProvider<ImagePickerNotifier, bool>(
  (ref) => ImagePickerNotifier(),
);
