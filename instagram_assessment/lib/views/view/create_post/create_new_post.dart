import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/views/constants/app_colors.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/constants/text_messages.dart';
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.keyboard_arrow_left,
          ),
        ),
        flexibleSpace: const FlexibleSpaceBar(
          centerTitle: true,
          title: Center(
            child: Text(
              TextMessage.createNewPost,
              style: TextStyle(
                color: Colors.black,
                fontSize: Dimension.fontSize15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                AssetsPath.testPostImage,
                scale: Dimension.scale1dot2,
              ),
            ),
            //text field
            Padding(
              padding: const EdgeInsets.only(
                  right: Dimension.width10,
                  left: Dimension.width10,
                  top: Dimension.height7,
                  bottom: Dimension.height7),
              child: TextField(
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
                  counterText: '',
                ),
                cursorColor: AppColor.facebookColor,
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.only(
                left: Dimension.width20,
                right: Dimension.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsPath.personalButton,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: Dimension.width20),
                    child: Text(
                      TextMessage.tagOthers,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right_outlined,
                    ),
                  ),
                ],
              ),
            ),
            const HorizontalDevider(),
            Padding(
              padding: const EdgeInsets.only(
                left: Dimension.width20,
                right: Dimension.width20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.eye),
                  const Padding(
                    padding: EdgeInsets.only(left: Dimension.width20),
                    child: Text(
                      TextMessage.object,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right_outlined,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: TextButton(
          onPressed: () {},
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: Dimension.height35,
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
