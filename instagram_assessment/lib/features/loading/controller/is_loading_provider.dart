import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/comment/controller/comment_controller.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/features/response/controller/response_controller.dart';

final isLoadingProvider = Provider.autoDispose<bool>((ref) {
  final authState = ref.watch(authProvider);
  final isUploadingImage = ref.watch(postProvider);
  final isImagePicker = ref.watch(imagePickerProvider);
  final isSendComment = ref.watch(commentProvider);
  final isSendResponse = ref.watch(responseProvider);

  return authState ||
      isUploadingImage ||
      isImagePicker ||
      isSendComment ||
      isSendResponse;
});
