import 'dart:typed_data';

import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:screenshot/screenshot.dart';

class AdjustScreen extends ConsumerStatefulWidget {
  const AdjustScreen({super.key});

  @override
  ConsumerState<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends ConsumerState<AdjustScreen> {
  double _brightness = 0;
  double _contrast = 0;
  double _saturation = 0;
  double _hue = 0;
  double _sepia = 0;

  late ColorFilterGenerator _colorFilterGenerator;

  final ScreenshotController screenshotController = ScreenshotController();

  bool _showBightness = false;
  bool _showConstrast = false;
  bool _showSaturation = false;
  bool _showHue = false;
  bool _showSepia = false;

  @override
  void initState() {
    _updateColorFilterGenerator();
    super.initState();
  }

  void _showSlider(
      {bool? brightness,
      bool? contrast,
      bool? saturation,
      bool? hue,
      bool? sepia}) {
    setState(() {
      _showBightness = brightness ?? false;
      _showConstrast = contrast ?? false;
      _showSaturation = saturation ?? false;
      _showHue = hue ?? false;
      _showSepia = sepia ?? false;
    });
  }

  void _resetAdjustments() {
    setState(() {
      _brightness = 0;
      _contrast = 0;
      _saturation = 0;
      _hue = 0;
      _sepia = 0;
    });

    _updateColorFilterGenerator();
  }

  void _updateColorFilterGenerator() {
    _colorFilterGenerator = ColorFilterGenerator(name: 'Adjust', filters: [
      ColorFilterAddons.brightness(_brightness),
      ColorFilterAddons.contrast(_contrast),
      ColorFilterAddons.saturation(_saturation),
      ColorFilterAddons.hue(_hue),
      ColorFilterAddons.sepia(_sepia),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text('Adjust'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
              onPressed: () async {
                Uint8List? bytes = await screenshotController.capture();
                ref.read(imagePickerProvider.notifier).updateFile(bytes);
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done))
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
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(_colorFilterGenerator.matrix),
                  child: Image.memory(
                    ref.watch(imagePickerProvider)!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildSlider(label: 'Brightness', value: _brightness, onChanged: (value) => setState(() {
                      _brightness = value;
                      _updateColorFilterGenerator();
                    }), show: _showBightness),
                    _buildSlider(label: 'Contrast', value: _contrast, onChanged: (value) => setState(() {
                      _contrast = value;
                      _updateColorFilterGenerator();
                    }), show: _showConstrast),
                    _buildSlider(label: 'Saturation', value: _saturation, onChanged: (value) => setState(() {
                      _saturation = value;
                      _updateColorFilterGenerator();
                    }), show: _showSaturation),
                    _buildSlider(label: 'Hue', value: _hue, onChanged: (value) => setState(() {
                      _hue = value;
                      _updateColorFilterGenerator();
                    }), show: _showHue),
                    _buildSlider(label: 'Sepia', value: _sepia, onChanged: (value) => setState(() {
                      _sepia = value;
                      _updateColorFilterGenerator();
                    }), show: _showSepia),
                    
                  ],
                )),
                TextButton(
                    onPressed: _resetAdjustments,
                    child: const Text(
                      'Reset',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 58,
        color: Colors.black,
        child: SafeArea(
            child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _bottomBarItem(Icons.brightness_4_rounded, 'Brightness',
                  onPress: () {
                _showSlider(brightness: true);
              }),
              _bottomBarItem(Icons.contrast, 'Contrast', onPress: () {
                _showSlider(contrast: true);
              }),
              _bottomBarItem(Icons.water_drop, 'Saturation', onPress: () {
                _showSlider(saturation: true);
              }),
              _bottomBarItem(Icons.filter_tilt_shift, '   Hue   ', onPress: () {
                _showSlider(hue: true);
              }),
              _bottomBarItem(Icons.motion_photos_on, '   Sepia   ',
                  onPress: () {
                _showSlider(sepia: true);
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
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSlider(
      {required String label,
      required double value,
      required ValueChanged<double> onChanged,
      required bool show}) {
    return Visibility(
      visible: show,
      child: Slider(
        value: value,
        label: label,
        max: 1,
        min: -0.9,
        onChanged: onChanged,
      ),
    );
  }
}
