import 'package:flutter/material.dart';
import 'package:instagram_assessment/features/picker/model/thumbnail_request.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/thumbnail_post_image.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/tiles/object_other_tile.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/tiles/tag_other_tile.dart';
import 'package:instagram_assessment/config/views/text_field/flexible_text_field.dart';
import 'package:instagram_assessment/config/views/divider/horizontal_divider_view.dart';

class PostCreationView extends StatelessWidget {
  final TextEditingController postController;
  final ThumbnailRequest thumbnailRequest;
  const PostCreationView(
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
