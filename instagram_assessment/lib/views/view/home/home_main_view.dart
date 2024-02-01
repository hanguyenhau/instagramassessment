import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_assessment/states/upload_image/models/file_type.dart';
import 'package:instagram_assessment/states/upload_image/provider/image_picker_provider.dart';
import 'package:instagram_assessment/views/constants/assets_path.dart';
import 'package:instagram_assessment/views/constants/dimension.dart';
import 'package:instagram_assessment/views/view/create_post/create_new_post.dart';
import 'package:instagram_assessment/views/view/user/horizontal/user_horizontal_list_view.dart';
import 'package:instagram_assessment/views/view/login/horizontal_divider_view.dart';
import 'package:instagram_assessment/views/view/post_listing/all_post_refresh_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
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

          //Add new Post
          TextButton(
            onPressed: () async {
              final imageFile =
                  await ref.watch(imagePickerProvider.notifier).getFile();

              if (imageFile == null) {
                return;
              }

              if (!mounted) {
                return;
              }

              // go to create new post
              Future.delayed(Duration.zero, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return CreateNewPost(
                        fileToPost: imageFile,
                        fileType: FileType.image,
                      );
                    },
                  ),
                );
              });
            },
            child: Image.asset(
              AssetsPath.addButton,
              width: Dimension.width26,
              height: Dimension.height26,
            ),
          ),

          //Favorite post
          TextButton(
            onPressed: () {},
            child: Image.asset(
              AssetsPath.favoriteButton,
              width: Dimension.width30,
              height: Dimension.height30,
            ),
          ),

          //Chat App
          TextButton(
            onPressed: () {
              ref.watch(authStateProvider.notifier).logOut();
            },
            child: Image.asset(
              AssetsPath.messageButton,
              width: Dimension.width26,
              height: Dimension.height26,
            ),
          ),
        ],
      ),
      body: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: UserHorizontalListView(),
          ),
          SliverToBoxAdapter(
            child: HorizontalDevider(),
          ),
          SliverToBoxAdapter(
            child: AllPostRefreshView(),
          ),
        ],
      ),
    );
  }
}
