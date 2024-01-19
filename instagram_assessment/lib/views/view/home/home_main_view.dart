import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_assessment/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_assessment/states/upload_image/helpers/image_picker_helper.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/home/user_horizontal_view.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';
import 'package:instagram_assessment/views/view/post/view_details_post/view_post_view.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Transform.scale(
          scale: Dimension.scale0dot6,
          child: Image.asset(
            AssetsPath.instagram,
            fit: BoxFit.cover,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          const SizedBox(
            width: 10,
          ),
          TextButton(
            onPressed: () {

            },
            child: Image.asset(
              AssetsPath.addButton,
              width: Dimension.width30,
              height: Dimension.height30,
            ),
          ),
          TextButton(
            onPressed: () {
              final imageFile = ImagePickerHelper.pickImageFromGallery();
            },
            child: Image.asset(
              AssetsPath.favoriteButton,
              width: Dimension.width30,
              height: Dimension.height30,
            ),
          ),
          TextButton(
            onPressed: () {
              ref.watch(authStateProvider.notifier).logOut();
            },
            child: Image.asset(
              AssetsPath.messageButton,
              width: Dimension.width30,
              height: Dimension.height30,
            ),
          ),
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            UserHorizontalView(),
            HorizontalDevider(),
            PostMainView(),
          ],
        ),
      ),
    );
  }
}
