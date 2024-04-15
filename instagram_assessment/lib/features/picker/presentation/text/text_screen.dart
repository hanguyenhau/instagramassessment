import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/text/fonts.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:text_editor/text_editor.dart';

class TextScreen extends ConsumerStatefulWidget {
  const TextScreen({super.key});

  @override
  ConsumerState<TextScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<TextScreen> {
  late LindiController controller;

  bool showEditor = false;

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
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.black,
            title: const Text('Text'),
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
          body: Center(
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
              ),
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(),
        ),
        if (showEditor)
          Scaffold(
              backgroundColor: Colors.black.withOpacity(0.75),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextEditor(
                    fonts: Fonts().list(),
                    textStyle: const TextStyle(color: Colors.white),
                    minFontSize: 10,
                    maxFontSize: 70,
                    onEditCompleted: (style, align, text) {
                      setState(() {
                        showEditor = false;
                        if (text.isNotEmpty) {
                          controller.addWidget(Text(
                            text,
                            textAlign: align,
                            style: style,
                          ));
                        }
                      });
                    },
                  ),
                ),
              ))
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
        width: double.infinity,
        height: 50,
        color: Colors.black,
        child: Center(
          child: TextButton(
            onPressed: () {
              setState(() {
                showEditor = true;
              });
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                Text(
                  'Add Text',
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
          ),
        ));
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
                color: Colors.transparent,
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
