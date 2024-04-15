import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/mask/gesture_detector_widget.dart';
import 'package:instagram_assessment/features/picker/presentation/mask/shapes.dart';
import 'package:screenshot/screenshot.dart';
import 'package:widget_mask/widget_mask.dart';

class MaskScreen extends ConsumerStatefulWidget {
  const MaskScreen({super.key});

  @override
  ConsumerState<MaskScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<MaskScreen> {
  ScreenshotController screenshotController = ScreenshotController();

  BlendMode blendMode = BlendMode.dstIn;
  IconData iconData = Shapes().list()[0];
  double opacity = 1;

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
        title: const Text('Mask'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final bytes = await screenshotController.capture();
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
      body: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Screenshot(
                controller: screenshotController,
                child: WidgetMask(
                  blendMode: blendMode,
                  mask: Stack(
                    children: [
                      Container(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      GestureDetectorWidget(
                        child: Icon(
                          iconData,
                          size: 250,
                          color: Colors.white.withOpacity(opacity),
                        ),
                      )
                    ],
                  ),
                  child: Image.memory(
                    ref.watch(imagePickerProvider)!,
                    fit: BoxFit.cover,
                  ),
                ))),
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(imageProvider: imageProvider),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
        width: double.infinity,
        height: 120,
        color: Colors.black,
        child: SafeArea(
            child: Column(
          children: [
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      setState(() {
                        opacity = 1;
                        blendMode = BlendMode.dstIn;
                      });
                    },
                    child: const Text(
                      'DstIn',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        blendMode = BlendMode.overlay;
                      });
                    },
                    child: const Text(
                      'Overlay',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        blendMode = BlendMode.screen;
                      });
                    },
                    child: const Text(
                      'Screen',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        blendMode = BlendMode.saturation;
                      });
                    },
                    child: const Text(
                      'Modulate',
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      setState(() {
                        blendMode = BlendMode.difference;
                      });
                    },
                    child: const Text(
                      'Difference',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (int i = 0; i < Shapes().list().length; i++)
                      _bottomBarItem(
                        icon: Shapes().list()[i],
                        onPress: () {
                          setState(() {
                            iconData = Shapes().list()[i];
                          });
                        },
                        idx: i,
                      )
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  Widget _bottomBarItem(
      {required IconData icon,
      required VoidCallback onPress,
      required int idx}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          )),
    );
  }

  Widget _iconItem({required IconData icon, required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
