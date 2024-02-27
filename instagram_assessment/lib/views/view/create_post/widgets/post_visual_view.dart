import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/upload_image/models/thumbnail_request.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/views/view/create_post/widgets/image/thumbnail_post_image.dart';
import 'package:instagram_assessment/views/view/create_post/widgets/list_tile/object_other_tile.dart';
import 'package:instagram_assessment/views/view/create_post/widgets/list_tile/tag_other_tile.dart';
import 'package:instagram_assessment/views/components/text_field/flexible_text_field.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';

class PostVisualView extends StatelessWidget {
  final TextEditingController postController;
  final ThumbnailRequest thumbnailRequest;
  const PostVisualView(
      {super.key,
      required this.postController,
      required this.thumbnailRequest});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //Thumnail Image
        Center(
          child: ThumbnailPostImage(thumbnailRequest: thumbnailRequest),
        ),
        
        //text field
        FlexibleTextView(
          controller: postController,
          hintText: TextMessage.writeCaption,
        ),

        //Tag other tile
        const TagOtherTile(),
        const HorizontalDevider(),
        //Object other tile
        const ObjectOtherTile(),
      ],
    );
  }
}
