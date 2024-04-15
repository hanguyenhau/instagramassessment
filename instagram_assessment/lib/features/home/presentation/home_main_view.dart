import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/controller/auth_controller.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/picker/presentation/image_picker_display.dart';
import 'package:instagram_assessment/features/user/presentation/view/list/user_list_view.dart';
import 'package:instagram_assessment/config/views/divider/horizontal_divider_view.dart';
import 'package:instagram_assessment/features/post/presentation/view/show_all_posts_view.dart';

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
              await ref.watch(imagePickerProvider.notifier).getFile();

              if (ref.watch(imagePickerProvider) == null || !mounted) {
                return;
              }

              // go to create new post
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return const ImagePickerDisplay();
                  },
                ),
              );
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
              ref.read(authProvider.notifier).logOut();
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
            child: ShowAllPostsView(),
          ),
        ],
      ),
    );
  }
}
