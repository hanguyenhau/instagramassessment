import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/post/controller/post_controller.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
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
                //save post to firebase
                final isUpload = await ref
                    .read(postProvider.notifier)
                    .uploadPost(
                        file: fileToPost,
                        filetype: fileType,
                        messenger: message,
                        );

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
