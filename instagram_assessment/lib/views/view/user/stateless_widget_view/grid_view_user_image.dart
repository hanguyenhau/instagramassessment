import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/assets_path.dart';

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
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 2.0,
        mainAxisExtent: 150,
        mainAxisSpacing: 2.0,
      ),
      itemCount: 7,
      itemBuilder: (context, index) {
        return SizedBox(
          height: MediaQuery.of(context).size.width /
              3, // Adjust the height as needed
          child: Image.asset(
            images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}
