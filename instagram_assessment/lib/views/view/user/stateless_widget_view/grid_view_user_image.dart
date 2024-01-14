import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';
import 'package:instagram_assessment/constants/views/dimension.dart';

class GridViewUserImages extends StatelessWidget {
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
  GridViewUserImages({
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
