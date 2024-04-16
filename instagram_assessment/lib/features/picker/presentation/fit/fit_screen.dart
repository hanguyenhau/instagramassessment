import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/fit/blur_image_controller.dart';
import 'package:instagram_assessment/features/picker/controller/fit/color_image_controller.dart';
import 'package:instagram_assessment/features/picker/controller/fit/ratio_image_controller.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/picker_type.dart';
import 'package:instagram_assessment/features/picker/presentation/fit/component/blur_widget.dart';
import 'package:instagram_assessment/features/picker/presentation/fit/component/color_widget.dart';
import 'package:instagram_assessment/features/picker/presentation/fit/component/ratio_widget.dart';
import 'package:screenshot/screenshot.dart';

class FitScreen extends ConsumerStatefulWidget {
  const FitScreen({super.key});

  @override
  ConsumerState<FitScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<FitScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
  }

  Fit _selectedFit = Fit.ratio;

  void _activeFitWidget({required Fit selected}) {
    setState(() {
      _selectedFit = selected;
    });
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
        title: const Text('Fit'),
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
      body: Center(
        child: AspectRatio(
          aspectRatio: ref.watch(ratioFitProvider),
          child: Screenshot(
              controller: _screenshotController,
              child: Stack(
                children: [
                  //change background by color if color fit is chose
                  if (_selectedFit == Fit.color)
                    Container(
                      color: ref.watch(colorFitProvider),
                    ),
                  //change background by blur if blur fit is chose
                  if (_selectedFit == Fit.blur)
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(ref.watch(blurBackgroundProvider)),
                        ),
                      ),
                    ).blurred(
                      colorOpacity: 0,
                      blur: ref.watch(blurFitProvider),
                    ),
                  Center(
                    child: Image.memory(imageProvider),
                  )
                ],
              )),
        ),
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(imageProvider: imageProvider),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.black,
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                if (_selectedFit == Fit.ratio) const RatioWidget(),
                if (_selectedFit == Fit.blur) const BlurWidget(),
                if (_selectedFit == Fit.color)
                  ColorWidget(imageProvider: imageProvider),
              ],
            ),
          ),
          Row(
            children: [
              _bottomBarItem(Icons.aspect_ratio, Fit.ratio.name, onPress: () {
                _activeFitWidget(selected: Fit.ratio);
              }),
              _bottomBarItem(Icons.blur_linear, Fit.blur.name, onPress: () {
                _activeFitWidget(selected: Fit.blur);
              }),
              _bottomBarItem(Icons.color_lens_outlined, Fit.color.name,
                  onPress: () {
                _activeFitWidget(selected: Fit.color);
              }),
            ],
          ),
        ],
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
