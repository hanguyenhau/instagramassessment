import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/picker/model/thumbnail_request.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/post_creation_appbar.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/post_creation_view.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/post_creation_upload_button.dart';

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
          child: PostCreationView(
        postController: postController,
        thumbnailRequest: thumbnailRequest,
      )),
      bottomNavigationBar: UploadPost(
        ref: ref,
        fileToPost: widget.fileToPost,
        fileType: widget.fileType,
        isPostButtonEnable: isPostButtonEnable.value,
        message: postController.text,
      ),
    );
  }
}
