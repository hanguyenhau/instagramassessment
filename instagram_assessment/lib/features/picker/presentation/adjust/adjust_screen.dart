import 'package:colorfilter_generator/addons.dart';
import 'package:colorfilter_generator/colorfilter_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:screenshot/screenshot.dart';

class AdjustScreen extends ConsumerStatefulWidget {
  const AdjustScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends ConsumerState<AdjustScreen> {
  late ColorFilterGenerator _colorFilterGenerator;
  final ScreenshotController _screenshotController = ScreenshotController();

  final Map<String, double> _adjustments = {
    'brightness': 0.0,
    'contrast': 0.0,
    'saturation': 0.0,
    'hue': 0.0,
    'sepia': 0.0,
  };

  String _selectedAdjustment = 'brightness';

  void _showSlider(String adjustment) {
    setState(() {
      _selectedAdjustment = adjustment;
    });
  }

  void _updateColorFilterGenerator() {
    _colorFilterGenerator = ColorFilterGenerator(name: 'Adjust', filters: [
      ColorFilterAddons.brightness(_adjustments['brightness']!),
      ColorFilterAddons.contrast(_adjustments['contrast']!),
      ColorFilterAddons.saturation(_adjustments['saturation']!),
      ColorFilterAddons.hue(_adjustments['hue']!),
      ColorFilterAddons.sepia(_adjustments['sepia']!),
    ]);
  }

  @override
  void initState() {
    _updateColorFilterGenerator();
    super.initState();
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
                    children: _adjustments.entries
                        .map((adjust) => _buildSlider(
                            label: adjust.key.capitalize(),
                            value: adjust.value,
                            onChanged: (value) => setState(() {
                                  _adjustments[adjust.key] = value;
                                  _updateColorFilterGenerator();
                                }),
                            show: adjust.key == _selectedAdjustment))
                        .toList(),
                  ),
                ),
                TextButton(
                  onPressed: _resetAdjustments,
                  child: const Text(
                    'Reset',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    required bool show,
  }) {
    return Visibility(
      visible: show,
      child: Slider(
        value: value,
        label: label,
        max: 1,
        min: -0.9,
        thumbColor: AppColor.facebookColor,
        activeColor: AppColor.facebookColor,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: 58,
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _adjustments.entries.map((entry) {
              final key = entry.key;
              return _bottomBarItem(
                icon: _getIconForAdjustment(key),
                title: key.capitalize(),
                onPress: () {
                  _showSlider(key);
                },
                selected: key == _selectedAdjustment,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _bottomBarItem({
    required IconData icon,
    required String title,
    required VoidCallback onPress,
    required bool selected,
  }) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: selected ? AppColor.facebookColor : Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                color: selected ? AppColor.facebookColor : Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  IconData _getIconForAdjustment(String adjustment) {
    switch (adjustment) {
      case 'brightness':
        return Icons.brightness_4_rounded;
      case 'contrast':
        return Icons.contrast;
      case 'saturation':
        return Icons.water_drop;
      case 'hue':
        return Icons.filter_tilt_shift;
      case 'sepia':
        return Icons.motion_photos_on;
      default:
        return Icons.error;
    }
  }

  void _resetAdjustments() {
    setState(() {
      _adjustments.forEach((key, _) {
        _adjustments[key] = 0.0;
      });
    });
    _updateColorFilterGenerator();
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
