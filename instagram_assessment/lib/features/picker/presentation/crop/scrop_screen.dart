import 'dart:typed_data';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/extension/main_exception.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'dart:ui' as ui;

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
        actions: [
          IconButton(
              onPressed: () async {
                final bytes = await _cropAndConvertImage();
                ref
                    .read(imagePickerProvider.notifier)
                    .updateFile(await bytes.imageToFile());
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: CropImage(
        image: Image.file(imageProvider),
        controller: controller,
        alwaysMove: true,
        gridThickWidth: 6,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: Dimension.height60,
      color: Colors.black,
      child: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildBottomBarCropItem(),
        ),
      )),
    );
  }

  List<Widget> _buildBottomBarCropItem() {
    return [
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
      ...[
        [1, '1:1'],
        [2, '2:1'],
        [1 / 2, '1:2'],
        [4 / 3, '4:3'],
        [3 / 4, '3:4'],
        [16 / 9, '16:9'],
        [9 / 16, '9:16'],
      ].map((data) => _bottomBarItem(
          child: Text(
            data[1] as String,
            style: const TextStyle(color: Colors.white),
          ),
          onPress: () => _setAspectRatio(data[0] as double)))
    ];
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

  void _setAspectRatio(double ratio) {
    controller.aspectRatio = ratio;
    controller.crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
  }

  Future<Uint8List> _cropAndConvertImage() async {
    final ui.Image bitmap = await controller.croppedBitmap();
    final ByteData? data = await bitmap.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
