import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/picker/model/picker_type.dart';
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
        title: const Text(TextMessage.photoEditor),
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
              child: const Text(TextMessage.create))
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
        height: Dimension.height60,
        color: Colors.black,
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _bottomBarItem(Icons.crop_rotate, TextMessage.crop, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.crop.name}');
              }),
              _bottomBarItem(Icons.filter_vintage_outlined, TextMessage.filters,
                  onPress: () {
                _navigateToRouteView(context: context, route:'/${Picker.filter.name}');
              }),
              _bottomBarItem(Icons.tune, TextMessage.adjust, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.adjust.name}');
              }),
              _bottomBarItem(Icons.fit_screen_sharp, TextMessage.fit, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.fit.name}');
              }),
              _bottomBarItem(Icons.border_color_outlined, TextMessage.tint, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.tint.name}');
              }),
              _bottomBarItem(Icons.blur_circular, TextMessage.blur, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.blur.name}');
              }),
              _bottomBarItem(Icons.emoji_emotions_outlined, TextMessage.sticker,
                  onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.sticker.name}');
              }),
              _bottomBarItem(Icons.text_fields, TextMessage.text, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.text.name}');
              }),
              _bottomBarItem(Icons.draw, TextMessage.draw, onPress: () {
                _navigateToRouteView(context: context, route: '/${Picker.draw.name}');
              }),
              _bottomBarItem(Icons.star_outline, TextMessage.mask, onPress: () {
                _navigateToRouteView(context: context, route:'/${Picker.mask.name}');
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
        padding: const EdgeInsets.symmetric(horizontal: Dimension.height10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.white,
            ),
            const SizedBox(
              height: Dimension.height10,
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
