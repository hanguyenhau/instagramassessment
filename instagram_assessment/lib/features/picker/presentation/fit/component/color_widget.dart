import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/app_colors.dart';
import 'package:instagram_assessment/config/core/helper/pixel_helper.dart';
import 'package:instagram_assessment/features/picker/controller/fit/color_image_controller.dart';

class ColorWidget extends ConsumerWidget {
  final dynamic imageProvider;
  const ColorWidget({required this.imageProvider, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          IconButton(
              onPressed: () async {
                PixelHelperImage().colorPicker(
                  context,
                  backgroundColor: ref.watch(colorFitProvider),
                  onPick: (color) {
                    ref
                        .read(colorFitProvider.notifier)
                        .updateColor(value: color);
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
                    backgroundColor: ref.watch(colorFitProvider),
                    image: imageProvider, onPick: (color) {
                  ref.read(colorFitProvider.notifier).updateColor(value: color);
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
