import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/upload_button.dart';

class UploadPost extends StatelessWidget {
  final bool isPostButtonEnable;
  final WidgetRef ref;
  final FileType fileType;
  final String message;

  const UploadPost(
      {super.key,
      required this.isPostButtonEnable,
      required this.ref,
      required this.fileType,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: isPostButtonEnable
            ? () async {
                //save post to firebase
                final isUpload =
                    await ref.read(postProvider.notifier).uploadPost(
                          file: ref.watch(imagePickerProvider)!,
                          filetype: fileType,
                          messenger: message,
                        );

                if (isUpload && context.mounted) {
                  log('Upload success');
                  Navigator.of(context).pop();
                }
              }
            : null,
        child: UploadButton(
          isPostButtonEnable: isPostButtonEnable,
        ));
  }
}
