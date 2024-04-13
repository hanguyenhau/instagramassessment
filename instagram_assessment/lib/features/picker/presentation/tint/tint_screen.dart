import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/tint/listtint.dart';
import 'package:instagram_assessment/features/picker/presentation/tint/tint.dart';
import 'package:screenshot/screenshot.dart';

class TintScreen extends ConsumerStatefulWidget {
  const TintScreen({super.key});

  @override
  ConsumerState<TintScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<TintScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  late List<Tint> tints;

  int index = 0;

  @override
  void initState() {
    tints = Tints().list();
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
        title: const Text('Tint'),
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
                child: Image.memory(
                  ref.watch(imagePickerProvider)!,
                  fit: BoxFit.cover,
                  color: tints[index].color.withOpacity(tints[index].opacity),
                  colorBlendMode: BlendMode.color,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0, right: 0,
            child: Slider(
              value: tints[index].opacity,
              onChanged: (value) => setState(() {
                tints[index].opacity = value;
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
      max: 20.0,
      min: 1.0,
      value: value,
      onChanged: onChanged,
      label: value.toStringAsFixed(2),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black,
      child: SafeArea(
          child: Container(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            Tint tint = tints[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  this.index = index;
                });
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: CircleAvatar(
                    backgroundColor: this.index == index ? Colors.white : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: CircleAvatar(backgroundColor: tint.color),
                    )),
              ),
            );
          },
          shrinkWrap: true,
          itemCount: tints.length,
        ),
      )),
    );
  }

  Widget _bottomBarItem(IconData icon, String title, {required onPress}) {
    return Expanded(
        child: InkWell(
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
    ));
  }
}
