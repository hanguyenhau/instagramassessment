import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';
import 'package:instagram_assessment/views/view/create_post/widgets/button/share_post_button.dart';

class UploadPost extends StatelessWidget {
  final bool isPostButtonEnable;
  final WidgetRef ref;
  final File fileToPost;
  final FileType fileType;
  final String message;

  const UploadPost(
      {super.key,
      required this.isPostButtonEnable,
      required this.ref,
      required this.fileToPost,
      required this.fileType,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isPostButtonEnable
            ? () async {
                final userId = ref.read(userProvider);
                if (userId == null) {
                  return;
                }
                //save post to firebase
                final isUpload = await ref
                    .watch(imageUploadProvider.notifier)
                    .upload(
                        file: fileToPost,
                        filetype: fileType,
                        messenger: message,
                        userId: userId);

                if (isUpload && context.mounted) {
                  log('Upload success');
                  Navigator.of(context).pop();
                }
              }
            : null,
        child: SharePostButton(
          isPostButtonEnable: isPostButtonEnable,
        ));
  }
}
