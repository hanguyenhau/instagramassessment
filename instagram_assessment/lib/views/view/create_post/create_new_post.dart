import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/upload_image/models/thumbnail_request.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/create_post/create_post_appbar.dart';
import 'package:instagram_assessment/views/view/create_post/thumbnail_image_view.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';

class CreateNewPost extends ConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPost({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _postController = TextEditingController();
    final thumbnailRequest = ThumbnailRequest(
      fileToPost: fileToPost,
      fileType: fileType,
    );

    return Scaffold(
      appBar: CreatePostAppbar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ThumbnailImageView(thumbnailRequest: thumbnailRequest),
            ),
            //text field
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimension.width10,
                  left: Dimension.width10,
                  top: Dimension.height7,
                  bottom: Dimension.height7),
              child: TextField(
                controller: _postController,
                autofocus: true,
                maxLines: Dimension.maxLines4,
                maxLength: Dimension.maxLength200,
                decoration: InputDecoration(
                  hintText: TextMessage.writeCaption,
                  hintStyle: TextStyle(
                    color: AppColor.callToActionText,
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.callToActionButton,
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.callToActionButton,
                    ),
                  ),
                  counterText: '',
                ),
                cursorColor: AppColor.facebookColor,
              ),
            ),
            //
            ListTile(
              title: const Text(
                TextMessage.tagOthers,
              ),
              leading: Image.asset(
                AssetsPath.personalButton,
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right_outlined,
                ),
              ),
            ),
            const HorizontalDevider(),
            //
            ListTile(
              title: const Text(
                TextMessage.object,
              ),
              leading: const FaIcon(FontAwesomeIcons.eye),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.chevron_right_outlined,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
          onPressed: () async {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }

            //save post to firebase
            final isUpload = await ref
                .watch(imageUploadProvider.notifier)
                .upload(
                    file: fileToPost,
                    filetype: fileType,
                    messenger: _postController.text,
                    userId: userId);

            if (isUpload && context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: Dimension.height40,
            margin: const EdgeInsets.only(
                bottom: Dimension.height20, top: Dimension.height20),
            decoration: BoxDecoration(
              color: AppColor.facebookColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  Dimension.circular10,
                ),
              ),
            ),
            child: const Text(
              TextMessage.share,
              style: TextStyle(
                color: AppColor.whiteColor,
              ),
            ),
          )),
    );
  }
}
