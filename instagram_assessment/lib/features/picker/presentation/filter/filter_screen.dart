import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';
import 'package:instagram_assessment/config/core/extension/main_exception.dart';
import 'package:instagram_assessment/features/picker/controller/picker_controller.dart';
import 'package:instagram_assessment/features/picker/presentation/filter/data/filters_list.dart';
import 'package:instagram_assessment/features/picker/presentation/filter/model/filter.dart';
import 'package:screenshot/screenshot.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  late Filter currentFilter;
  late List<Filter> filters;

  ScreenshotController screenshotController = ScreenshotController();


  @override
  void initState() {
    filters = Filters().list();
    currentFilter = filters[0];
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
        title: const Text('Filter'),
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
                ref
                    .read(imagePickerProvider.notifier)
                    .updateFile(await bytes!.imageToFile());
                if (!mounted) return;
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Screenshot(controller: screenshotController, child: ColorFiltered(
          colorFilter: ColorFilter.matrix(currentFilter.matrix),
          child: Image.file(imageProvider),
        )),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: double.infinity,
      height: Dimension.height80,
      color: Colors.black,
      child: SafeArea(
          child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final Filter filter = filters[index];
          return _bottomBarItem(filter: filter, onPress: () {
            setState(() {
              currentFilter = filter;
            });
          });
        },
      )),
    );
  }

  Widget _bottomBarItem({required Filter filter, required onPress}) {
    final imageProvider = ref.watch(imagePickerProvider);
    if (imageProvider == null) {
      return Container();
    }
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(children: [
          Expanded(
            child: FittedBox(
              fit: BoxFit.cover,
              child: ColorFiltered(
                colorFilter: ColorFilter.matrix(
                  filter.matrix,
                ),
                child: Image.file(
                  imageProvider,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
              ),
            ),
          ),
          Text(
            filter.fileName,
            style: const TextStyle(color: Colors.white),
          ),
        ]),
      ),
    );
  }
}
