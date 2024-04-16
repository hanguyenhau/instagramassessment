import 'dart:typed_data';
import 'dart:ui';

import 'package:crop_image/crop_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/picker/controller/crop/crop_controller.dart';

import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'dart:ui' as ui;

class ScropScreen extends ConsumerWidget {
  const ScropScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text(TextMessage.crop),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                final bytes = await _cropAndConvertImage(ref: ref);
                ref.read(imagePickerProvider.notifier).updateFile(bytes);
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
          child: CropImage(
        image: Image.memory(imageProvider),
        controller: ref.watch(cropProvider),
        alwaysMove: true,
        gridThickWidth: 6,
      )),
      bottomNavigationBar: _buildBottomNavigationBar(ref: ref),
    );
  }

  Widget _buildBottomNavigationBar({required WidgetRef ref}) {
    return Container(
      width: double.infinity,
      height: Dimension.height60,
      color: Colors.black,
      child: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _buildBottomBarCropItem(ref: ref),
        ),
      )),
    );
  }

  List<Widget> _buildBottomBarCropItem({required WidgetRef ref}) {
    return [
      _bottomBarItem(
          onPress: () {
            ref.read(cropProvider).rotateLeft();
          },
          child: const Icon(
            Icons.rotate_90_degrees_ccw_outlined,
            color: Colors.white,
          )),
      _bottomBarItem(
          onPress: () {
            ref.read(cropProvider).rotateRight();
          },
          child: const Icon(Icons.rotate_90_degrees_cw_outlined,
              color: Colors.white)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          color: Colors.white,
          height: Dimension.height30,
          width: Dimension.width1,
        ),
      ),
      ...ref
          .read(cropProvider.notifier)
          .cropLists()
          .entries
          .map((data) => _bottomBarItem(
              child: Text(
                data.value,
                style: const TextStyle(color: Colors.white),
              ),
              onPress: () => _setAspectRatio(ratio: data.key, ref: ref)))
    ];
  }

  Widget _bottomBarItem({required child, required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimension.height10),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  void _setAspectRatio({required double ratio, required WidgetRef ref}) {
    ref.read(cropProvider).aspectRatio = ratio;
    ref.read(cropProvider).crop = const Rect.fromLTRB(0.1, 0.1, 0.9, 0.9);
  }

  Future<Uint8List> _cropAndConvertImage({required WidgetRef ref}) async {
    final ui.Image bitmap = await ref.read(cropProvider).croppedBitmap();
    final ByteData? data = await bitmap.toByteData(format: ImageByteFormat.png);
    return data!.buffer.asUint8List();
  }
}
