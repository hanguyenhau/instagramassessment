import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:routemaster/routemaster.dart';

class ImagePickerDisplay extends ConsumerWidget {
  const ImagePickerDisplay({super.key});

  void _navigateToRouteView({required BuildContext context,required String route}) =>
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
        actions: [TextButton(onPressed: () {}, child: const Text('Save'))],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Image.file(
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
              _bottomBarItem(Icons.filter_vintage_outlined, 'Filters', onPress: () {
                 _navigateToRouteView(context: context, route: 'filter');
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
