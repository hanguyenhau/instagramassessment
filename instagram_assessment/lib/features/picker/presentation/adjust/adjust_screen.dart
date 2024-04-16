import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/constants/text_messages.dart';
import 'package:instagram_assessment/features/picker/controller/adjust/adjust_controller.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/model/picker_type.dart';
import 'package:screenshot/screenshot.dart';

class AdjustScreen extends ConsumerStatefulWidget {
  const AdjustScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AdjustScreen> createState() => _AdjustScreenState();
}

class _AdjustScreenState extends ConsumerState<AdjustScreen> {
  final ScreenshotController _screenshotController = ScreenshotController();

  Adjust _selectedAdjustment = Adjust.brightness;

  void _selectAdjustment(Adjust adjustment) {
    setState(() {
      _selectedAdjustment = adjustment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Text(TextMessage.adjust),
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
              padding: const EdgeInsets.symmetric(vertical: Dimension.width10),
              child: Screenshot(
                controller: _screenshotController,
                child: ColorFiltered(
                  colorFilter: ColorFilter.matrix(
                      ref.watch(colorFilterGeneratorProvider).matrix),
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
                    children: ref
                        .watch(adjustProvider)
                        .entries
                        .map((adjust) => _buildSlider(
                            label: adjust.key.name,
                            value: adjust.value,
                            onChanged: (value) => setState(() {
                                  ref
                                      .read(adjustProvider.notifier)
                                      .updateAdjustment(
                                          adjust: adjust.key, value: value);
                                }),
                            show: adjust.key == _selectedAdjustment))
                        .toList(),
                  ),
                ),
                TextButton(
                  onPressed: () => ref.read(adjustProvider.notifier).resetAdjustments(),
                  child: const Text(
                    TextMessage.reset,
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
      height: Dimension.height60,
      color: Colors.black,
      child: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: ref.read(adjustProvider).entries.map((entry) {
              final key = entry.key;
              return _bottomBarItem(
                icon: _getIconForAdjustment(key),
                title: key.name,
                onPress: () {
                  _selectAdjustment(key);
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
              height: Dimension.height10,
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

  IconData _getIconForAdjustment(Adjust adjustment) {
    switch (adjustment) {
      case Adjust.brightness:
        return Icons.brightness_4_rounded;
      case Adjust.contrast:
        return Icons.contrast;
      case Adjust.saturation:
        return Icons.water_drop;
      case Adjust.hue:
        return Icons.filter_tilt_shift;
      case Adjust.sepia:
        return Icons.motion_photos_on;
      default:
        return Icons.error;
    }
  }
}