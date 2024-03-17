import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/assets_path.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class ShowAllPostGridView extends StatelessWidget {
  final List<String> images = [
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    AssetsPath.testPostImage,
    // Add more image URLs as needed
  ];
  ShowAllPostGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Dimension.crossAxisCount,
        childAspectRatio: Dimension.childAspectRatio,
        crossAxisSpacing: Dimension.crossAxisSpacing,
        mainAxisExtent: Dimension.mainAxisExtent,
        mainAxisSpacing: Dimension.mainAxisSpacing,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return // Adjust the height as needed
            Image.asset(
          images[index],
          fit: BoxFit.cover,
        );
      },
    );
  }
}
