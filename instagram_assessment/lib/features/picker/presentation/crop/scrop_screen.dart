import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';

class ScropScreen extends ConsumerStatefulWidget {
  const ScropScreen({super.key});

  @override
  ConsumerState<ScropScreen> createState() => _CropScreenState();
}

class _CropScreenState extends ConsumerState<ScropScreen> {
  late final CropController controller;

  @override
  void initState() {
    super.initState();
    controller = CropController(
      aspectRatio: 1,
      defaultCrop: const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageProvider = ref.watch(imagePickerProvider);
    if (imageProvider == null) {
      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(), // Show a loading indicator while waiting for the image
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Crop'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.done))],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: CropImage(
        image: Image.file(imageProvider),
        controller: controller,
        alwaysMove: true,
        gridThickWidth: 6,
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
              _bottomBarItem(
                  onPress: () {
                    controller.rotateLeft();
                  },
                  child: const Icon(
                    Icons.rotate_90_degrees_ccw_outlined,
                    color: Colors.white,
                  )),
              _bottomBarItem(
                  onPress: () {
                    controller.rotateRight();
                  },
                  child: const Icon(Icons.rotate_90_degrees_cw_outlined,
                      color: Colors.white)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  color: Colors.white,
                  height: 30,
                  width: 1,
                ),
              ),
              _bottomBarItem(
                  onPress: () {},
                  child: const Text('Free',
                      style: TextStyle(color: Colors.white))),
              _bottomBarItem(
                  onPress: () {},
                  child:
                      const Text('2.1', style: TextStyle(color: Colors.white))),
              _bottomBarItem(
                  onPress: () {},
                  child:
                      const Text('1.2', style: TextStyle(color: Colors.white))),
              _bottomBarItem(
                  onPress: () {},
                  child:
                      const Text('4.3', style: TextStyle(color: Colors.white))),
              _bottomBarItem(
                  onPress: () {},
                  child: const Text('16.9',
                      style: TextStyle(color: Colors.white))),
            ],
          ),
        )),
      ),
    );
  }

  Widget _bottomBarItem({required child, required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Center(
          child: child,
        ),
      ),
    );
  }
}
