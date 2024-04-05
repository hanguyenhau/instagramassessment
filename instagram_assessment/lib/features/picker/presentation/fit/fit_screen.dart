import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';

class FitScreen extends ConsumerStatefulWidget {
  const FitScreen({super.key});

  @override
  ConsumerState<FitScreen> createState() => _FitScreenState();
}

class _FitScreenState extends ConsumerState<FitScreen> {
  @override
  void initState() {
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
              // ref
              //     .read(imagePickerProvider.notifier)
              //     .updateFile(bytes);
              if (!mounted) return;
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.memory(imageProvider),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: Dimension.height60,
      color: Colors.black,
      child: SafeArea(
        child: Row(
          children: [
            _bottomBarItem(Icons.aspect_ratio, 'Ratio', onPress: () {}),
            _bottomBarItem(Icons.blur_linear, 'Blur', onPress: () {}),
            _bottomBarItem(Icons.color_lens_outlined, 'Color', onPress: () {}),
            _bottomBarItem(Icons.texture, 'Texture', onPress: () {}),
          ],
        ),
      ),
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
