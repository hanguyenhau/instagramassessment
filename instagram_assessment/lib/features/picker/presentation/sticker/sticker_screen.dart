import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/sticker/sticker.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';

class StickerScreen extends ConsumerStatefulWidget {
  const StickerScreen({super.key});

  @override
  ConsumerState<StickerScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<StickerScreen> {
  late LindiController controller;
  int index = 0;

  @override
  void initState() {
    controller = LindiController();
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
        title: const Text('Sticker'),
        centerTitle: true,
        leading: CloseButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final bytes = await controller.saveAsUint8List();
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
                child: LindiStickerWidget(
                  controller: controller,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.memory(
                      ref.watch(imagePickerProvider)!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
        ],
      ),
      bottomNavigationBar:
          _buildBottomNavigationBar(imageProvider: imageProvider),
    );
  }

  Widget _buildBottomNavigationBar({required Uint8List imageProvider}) {
    return Container(
        width: double.infinity,
        height: 150,
        color: Colors.black,
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: Stickers().list()[index].length,
              itemBuilder: (context, idx) {
                final String sticker = Stickers().list()[index][idx];
                return _iconItem(
                    sticker: sticker,
                    onPress: () {
                      setState(() {
                        controller.addWidget(Image.asset(sticker));
                      });
                    });
              },
            )),
            Row(
              children: [
                for (int i = 0; i < Stickers().list().length; i++)
                  _bottomBarItem(
                    icon: Stickers().list()[i][0],
                    onPress: () {
                      setState(() {
                        index = i;
                      });
                    },
                    idx: i,
                  )
              ],
            )
          ],
        )));
  }

  Widget _bottomBarItem(
      {required String icon, required VoidCallback onPress, required int idx}) {
    return InkWell(
      onTap: onPress,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: idx == index ? Colors.blue : Colors.transparent,
                height: 2,
                width: 30,
                padding: const EdgeInsets.symmetric(horizontal: 8),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  icon,
                  width: 40,
                ),
              )
            ],
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
