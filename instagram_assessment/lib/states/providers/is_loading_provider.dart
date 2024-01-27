import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_picker_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isImagePicker = ref.watch(imagePickerProvider);

  return authState.isLoading || isUploadingImage || isImagePicker;
});
