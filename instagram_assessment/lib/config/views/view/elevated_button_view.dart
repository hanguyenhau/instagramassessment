import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/dimension.dart';

class ElevatedButtonView extends StatelessWidget {
  final String iconName;
  final double padding;
  const ElevatedButtonView({
    super.key,
    required this.iconName,
    this.padding = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Ink(
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.only(
              right: padding,
              left: padding,
            ),
            child: Image.asset(
              iconName,
              width: Dimension.width30,
              height: Dimension.height30,
            ),
          )),
    );
  }
}
