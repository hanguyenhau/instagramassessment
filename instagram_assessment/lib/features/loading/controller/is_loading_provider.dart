import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/states/comment/component/responses/provider/send_reponse_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_picker_provider.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isImagePicker = ref.watch(imagePickerProvider);
  final isSendComment = ref.watch(commentProvider);
  final isSendResponse = ref.watch(sendResponseProvider);

  return authState ||
      isUploadingImage ||
      isImagePicker ||
      isSendComment ||
      isSendResponse;
});
