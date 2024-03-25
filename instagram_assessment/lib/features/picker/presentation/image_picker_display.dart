import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/model/file_type.dart';
import 'package:instagram_assessment/features/post/presentation/create/elements/thumbnail_post_image.dart';
import 'package:routemaster/routemaster.dart';

class ImagePickerDisplay extends ConsumerWidget {
  const ImagePickerDisplay({super.key});

  void _navigateToScropView(BuildContext context) =>
      Routemaster.of(context).push('/i/crop');

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
        actions: [TextButton(onPressed: (){}, child: const Text('Save'))],
      ),
      backgroundColor: Colors.black,
      body: const Center(child: ThumbnailPostImage(fileType: FileType.image)),
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
                _navigateToScropView(context);
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
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
