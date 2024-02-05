import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_assessment/states/comment/provider/send_comment_provider.dart';
import 'package:instagram_assessment/states/comment/responses/provider/send_reponse_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_picker_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isImagePicker = ref.watch(imagePickerProvider);
  final isSendComment = ref.watch(sendCommentProvider);
  final isSendResponse = ref.watch(sendResponseProvider);

  return authState.isLoading ||
      isUploadingImage ||
      isImagePicker ||
      isSendComment || 
      isSendResponse;
});
