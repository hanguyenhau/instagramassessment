import 'dart:typed_data';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:pixel_color_picker/pixel_color_picker.dart';

class PixelHelperImage {
  show(BuildContext context,
      {required Color? backgroundColor,
      required Uint8List? image,
      required Function(Color) onPick}) {
    return showDialog(
      context: context,
      builder: (context) {
        Color tempColor = backgroundColor!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: const Text('Move your finger'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              PixelColorPicker(
                child: Image.memory(image!),
                onChanged: (color) => setState(() {
                  tempColor = color;
                }),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 80,
                color: tempColor,
              )
            ]),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    onPick(tempColor);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Pick'))
            ],
          ),
        );
      },
    );
  }

  colorPicker(BuildContext context,
      {required Color? backgroundColor, required Function(Color) onPick}) {
    return showDialog(
      context: context,
      builder: (context) {
        Color tempColor = backgroundColor ?? Colors.transparent;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            content: ColorPicker(
              onColorChanged: (value) => setState(() {
                tempColor = value;
              }),
              pickersEnabled: const <ColorPickerType, bool>{
                ColorPickerType.both: true,
                ColorPickerType.wheel: true,
                ColorPickerType.primary: true,
                ColorPickerType.accent: true
              },
              enableTonalPalette: true,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    onPick(tempColor);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Pick'))
            ],
          ),
        );
      },
    );
  }
}
