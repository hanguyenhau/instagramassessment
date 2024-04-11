import 'dart:typed_data';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/helper/pixel_helper.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/fit/fit.dart';
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

  double _blurValue = 0;

  Uint8List? _backgroundImage;
  Color _backgroundColor = Colors.white;

  double _ratioValue = 1;

  final Map<String, double> _ratio = {
    '1:1': 1 / 1,
    '1:2': 1 / 2,
    '2:1': 2 / 1,
    '4:3': 4 / 3,
    '3:4': 3 / 4,
    '16:9': 16 / 9,
    '9:16': 9 / 16,
  };

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
    _backgroundImage ??= imageProvider;
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
          aspectRatio: _ratioValue,
          child: Screenshot(
              controller: _screenshotController,
              child: Stack(
                children: [
                  if (_selectedFit == Fit.color)
                    Container(
                      color: _backgroundColor,
                    ),
                  if (_selectedFit == Fit.blur)
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(_backgroundImage!),
                        ),
                      ),
                    ).blurred(
                      colorOpacity: 0,
                      blur: _blurValue,
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
                if (_selectedFit == Fit.ratio) ratioWidget(),
                if (_selectedFit == Fit.blur) blurWidget(),
                if (_selectedFit == Fit.color)
                  colorWidget(imageProvider: imageProvider),
              ],
            ),
          ),
          Row(
            children: [
              _bottomBarItem(Icons.aspect_ratio, 'Ratio', onPress: () {
                _activeFitWidget(selected: Fit.ratio);
              }),
              _bottomBarItem(Icons.blur_linear, 'Blur', onPress: () {
                _activeFitWidget(selected: Fit.blur);
              }),
              _bottomBarItem(Icons.color_lens_outlined, 'Color', onPress: () {
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

  Widget ratioWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _ratio.entries
            .map(
              (entry) => TextButton(
                  onPressed: () {
                    setState(() {
                      _ratioValue = entry.value;
                    });
                  },
                  child: Text(entry.key)),
            )
            .toList(),
      ),
    );
  }

  Widget blurWidget() {
    return Container(
      color: Colors.black,
      child: Center(
        child: Row(children: [
          IconButton(
              onPressed: () async {
                _backgroundImage = await ref
                    .read(imagePickerProvider.notifier)
                    .getFileFromPicker();

                if (_backgroundImage == null || !mounted) {
                  return;
                }
                setState(() {});
              },
              icon: const Icon(
                Icons.photo_library_outlined,
                color: Colors.white,
              )),
          Expanded(
              child: Slider(
            value: _blurValue,
            label: _blurValue.toStringAsFixed(2),
            max: 100,
            min: 0,
            onChanged: (value) {
              setState(() {
                _blurValue = value;
              });
            },
          ))
        ]),
      ),
    );
  }

  Widget colorWidget({required Uint8List imageProvider}) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () async {
                PixelHelperImage().colorPicker(
                  context,
                  backgroundColor: _backgroundColor,
                  onPick: (color) {
                    setState(() {
                      _backgroundColor = color;
                    });
                  },
                );
              },
              icon: Icon(
                Icons.color_lens_outlined,
                color: AppColor.facebookColor,
              )),
          IconButton(
              onPressed: () async {
                PixelHelperImage().show(context,
                    backgroundColor: _backgroundColor,
                    image: imageProvider, onPick: (color) {
                  setState(() {
                    _backgroundColor = color;
                  });
                });
              },
              icon: Icon(
                Icons.colorize,
                color: AppColor.facebookColor,
              )),
        ]),
      ),
    );
  }
}
