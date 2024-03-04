import 'package:flutter/material.dart';

class RichTwoPartTextView extends StatelessWidget {
  final String leftPart;
  final String rightPart;
  const RichTwoPartTextView(
      {super.key, required this.leftPart, required this.rightPart});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
        TextSpan(
          text: leftPart,
          style: const TextStyle(color: Colors.black45, height: 12),
        ),
        TextSpan(
          text: ' $rightPart',
          style: const TextStyle(height: 14),
        ),
      ]),
    );
  }
}
