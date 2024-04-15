import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/helper/pixel_helper.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:painter/painter.dart';
import 'package:screenshot/screenshot.dart';

class DrawScreen extends ConsumerStatefulWidget {
  const DrawScreen({super.key});

  @override
  ConsumerState<DrawScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<DrawScreen> {
  ScreenshotController screenshotController = ScreenshotController();
  PainterController _controller = PainterController();

  @override
  void initState() {
    _controller.thickness = 5.0;
    _controller.backgroundColor = Colors.transparent;
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
        title: const Text('Draw'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // ref.read(imagePickerProvider.notifier).updateFile(bytes);
              // if (mounted) {
              //   Navigator.of(context).pop();
              // }
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
                    controller: screenshotController,
                    child: Stack(
                      children: [
                        Image.memory(
                          ref.watch(imagePickerProvider)!,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(child: Painter(_controller))
                      ],
                    ))),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: _controller.thickness+3,),
                      slider(
                        value: _controller.thickness,
                        onChanged: (value) {
                          setState(() {
                            _controller.thickness = value;
                          });
                        },
                      )
                    ],
                  )
                ],
              )),
        ],
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(imageProvider: imageProvider),
    );
  }

  Widget slider(
      {required double value, required ValueChanged<double> onChanged}) {
    return Slider(
      max: 20.0,
      min: 0.5,
      value: value,
      onChanged: onChanged,
      label: value.toStringAsFixed(2),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
        width: double.infinity,
        height: 50,
        color: Colors.black,
        child: Center(
          child: TextButton(
            onPressed: () {
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _bottomBarItem(
                    icon: Icons.undo,
                    onPress: () {
                      _controller.undo();
                    },
                  ),
                ),
                Expanded(
                  child: _bottomBarItem(
                    icon: Icons.delete,
                    onPress: () {
                      _controller.clear();
                    },
                  ),
                ),
                Expanded(
                  child: _bottomBarItem(
                    icon: Icons.color_lens_outlined,
                    onPress: () {
                      PixelHelperImage().colorPicker(
                        context,
                        backgroundColor: _controller.drawColor,
                        onPick: (color) {
                          setState(() {
                            _controller.drawColor = color;
                          });
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: _bottomBarItem(
                    icon: Icons.colorize,
                    onPress: () {
                      PixelHelperImage().show(context,
                          backgroundColor: _controller.drawColor,
                          image: imageProvider, onPick: (color) {
                        setState(() {
                          _controller.drawColor = color;
                        });
                      });
                    },
                  ),
                ),
                Expanded(
                    child: RotatedBox(
                  quarterTurns: _controller.eraseMode ? 2 : 0,
                  child: _bottomBarItem(
                    icon: Icons.create,
                    onPress: () {
                      _controller.eraseMode = !_controller.eraseMode;
                    },
                  ),
                ))
              ],
            ),
          ),
        ));
  }

  Widget _bottomBarItem(
      {required IconData icon, required VoidCallback onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
            ),
          )),
    );
  }

  Widget _iconItem({required String sticker, required onPress}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.cover,
          child: Image.asset(
            sticker,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }
}
