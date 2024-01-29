import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/user_id_provider.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/upload_image/models/thumbnail_request.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_upload_provider.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/create_post/create_post_appbar.dart';
import 'package:instagram_assessment/views/view/create_post/styles/custom_textfield.dart';
import 'package:instagram_assessment/views/view/create_post/styles/share_text_button_custom.dart';
import 'package:instagram_assessment/views/view/create_post/thumbnail_image_view.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';

class CreateNewPost extends StatefulHookConsumerWidget {
  final File fileToPost;
  final FileType fileType;

  const CreateNewPost({
    super.key,
    required this.fileToPost,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPost> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      fileToPost: widget.fileToPost,
      fileType: widget.fileType,
    );

    final postController = useTextEditingController();
    final isPostButtonEnable = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnable.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);

      return () {
        postController.removeListener(listener);
      };
    }, [postController]);

    return Scaffold(
      appBar: CreatePostAppbar(
        context: context,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Thumnail Image
            Center(
              child: ThumbnailImageView(thumbnailRequest: thumbnailRequest),
            ),
            //text field
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextField(
                controller: postController,
                hintText: TextMessage.writeCaption,
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
          onPressed: isPostButtonEnable.value
              ? () async {
                  final userId = ref.read(userIdProvider);
                  if (userId == null) {
                    return;
                  }
                  //save post to firebase
                  final isUpload = await ref
                      .watch(imageUploadProvider.notifier)
                      .upload(
                          file: widget.fileToPost,
                          filetype: widget.fileType,
                          messenger: postController.text,
                          userId: userId);

                  if (isUpload && context.mounted) {
                    log('Upload success');
                    Navigator.of(context).pop();
                  }
                }
              : null,
          child: ShareTextButtonCustom(
            isPostButtonEnable: isPostButtonEnable.value,
          )),
    );
  }
}
