import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:screenshot/screenshot.dart';

class BlurScreen extends ConsumerStatefulWidget {
  const BlurScreen({super.key});

  @override
  ConsumerState<BlurScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<BlurScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  double sigmaX = 0.1;
  double sigmaY = 0.1;
  TileMode tileMode = TileMode.decal;

  @override
  void initState() {
    super.initState();
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
        title: const Text('Blur'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final bytes = await _screenshotController.capture();
              ref.read(imagePickerProvider.notifier).updateFile(bytes);
              if (mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Screenshot(
                controller: _screenshotController,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                      sigmaX: sigmaX, sigmaY: sigmaY, tileMode: tileMode),
                  child: Image.memory(
                    ref.watch(imagePickerProvider)!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: slider(
              value: sigmaX,
              onChanged: (value) => setState(() {
                sigmaX = value;
              }),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: slider(
              value: sigmaY,
              onChanged: (value) => setState(() {
                sigmaY = value;
              }),
            ),
          )
        ],
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(imageProvider: imageProvider),
    );
  }

  Widget slider(
      {required double value, required ValueChanged<double> onChanged}) {
    return Slider(
      max: 10.0,
      min: 0.0,
      value: value,
      onChanged: onChanged,
      activeColor: AppColor.facebookColor,
      thumbColor: AppColor.facebookColor,
      label: value.toStringAsFixed(2),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
        width: double.infinity,
        height: 100,
        color: Colors.black,
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            _bottomBarItem(
                color:
                    tileMode == TileMode.decal ? Colors.blue : Colors.white70,
                title: "Decal",
                onPress: () {
                  setState(() {
                    tileMode = TileMode.decal;
                  });
                }),
            _bottomBarItem(
                color:
                    tileMode == TileMode.clamp ? Colors.blue : Colors.white70,
                title: "Clamp",
                onPress: () {
                  setState(() {
                    tileMode = TileMode.clamp;
                  });
                }),
            _bottomBarItem(
                color:
                    tileMode == TileMode.mirror ? Colors.blue : Colors.white70,
                title: "Mirror",
                onPress: () {
                  setState(() {
                    tileMode = TileMode.mirror;
                  });
                }),
            _bottomBarItem(
                color: tileMode == TileMode.repeated
                    ? Colors.blue
                    : Colors.white70,
                title: "Repeated",
                onPress: () {
                  setState(() {
                    tileMode = TileMode.repeated;
                  });
                }),
          ]),
        )));
  }

  Widget _bottomBarItem(
      {required Color color,
      required String title,
      required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            title,
            style: TextStyle(color: color),
          )),
    );
  }
}
