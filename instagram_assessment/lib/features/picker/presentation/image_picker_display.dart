import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/post/presentation/create/create_new_post.dart';
import 'package:routemaster/routemaster.dart';

class ImagePickerDisplay extends ConsumerWidget {
  const ImagePickerDisplay({super.key});

  void _navigateToRouteView(
          {required BuildContext context, required String route}) =>
      Routemaster.of(context).push('/i/$route');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Photo Editor'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                Future.delayed(Duration.zero, () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) {
                        return const CreateNewPost(
                          fileType: FileType.image,
                        );
                      },
                    ),
                  );
                });
              },
              child: const Text('Create'))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.memory(
          ref.watch(imagePickerProvider)!,
          fit: BoxFit.cover,
        ),
      )),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 58,
        color: Colors.black,
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _bottomBarItem(Icons.crop_rotate, 'Crop', onPress: () {
                _navigateToRouteView(context: context, route: 'crop');
              }),
              _bottomBarItem(Icons.filter_vintage_outlined, 'Filters',
                  onPress: () {
                _navigateToRouteView(context: context, route: 'filter');
              }),
              _bottomBarItem(Icons.tune, 'Adjust', onPress: () {
                _navigateToRouteView(context: context, route: 'adjust');
              }),
              _bottomBarItem(Icons.fit_screen_sharp, 'Fit', onPress: () {
                _navigateToRouteView(context: context, route: '/fit');
              }),
              _bottomBarItem(Icons.border_color_outlined, 'Tint', onPress: () {
                _navigateToRouteView(context: context, route: '/tint');
              }),
              _bottomBarItem(Icons.blur_circular, 'Blur', onPress: () {
                _navigateToRouteView(context: context, route: '/blur');
              }),
              _bottomBarItem(Icons.emoji_emotions_outlined, 'Sticker',
                  onPress: () {
                _navigateToRouteView(context: context, route: '/sticker');
              }),
              _bottomBarItem(Icons.text_fields, 'Text', onPress: () {
                _navigateToRouteView(context: context, route: '/text');
              }),
              _bottomBarItem(Icons.draw, 'Draw', onPress: () {
                _navigateToRouteView(context: context, route: '/draw');
              }),
              _bottomBarItem(Icons.star_outline, 'Mask', onPress: () {
                _navigateToRouteView(context: context, route: '/mask');
              }),
            ],
          ),
        )),
      ),
    );
  }

  Widget _bottomBarItem(IconData icon, String title, {required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
