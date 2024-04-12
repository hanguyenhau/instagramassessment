import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/fit/blur_image_controller.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';

class BlurWidget extends ConsumerWidget {
  const BlurWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Row(children: [
          IconButton(
              onPressed: () async {
                final backgroundImage = await ref
                    .read(imagePickerProvider.notifier)
                    .getFileFromPicker();

                if (backgroundImage == null) {
                  return;
                }

                ref.read(blurBackgroundProvider.notifier).updateBackground(image: backgroundImage);
              },
              icon: const Icon(
                Icons.photo_library_outlined,
                color: Colors.white,
              )),
          Expanded(
              child: Slider(
            value: ref.watch(blurFitProvider),
            label: ref.watch(blurFitProvider).toStringAsFixed(2),
            max: 100,
            min: 0,
            onChanged: (value) {
              ref.read(blurFitProvider.notifier).updateBlur(value: value);
            },
          ))
        ]),
      ),
    );
  }
}
