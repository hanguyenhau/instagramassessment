import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/upload_image/notifier/image_upload_notifier.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (ref) => ImageUploadNotifier(),
);
