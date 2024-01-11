import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/constants/views/app_colors.dart';

class CommentPostReadMoreTextView extends StatefulWidget {
  final String lastUserName;
  final String lastComment;
  final BuildContext context;
  const CommentPostReadMoreTextView({
    super.key,
    required this.lastUserName,
    required this.lastComment,
    required this.context,
  });

  @override
  State<CommentPostReadMoreTextView> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<CommentPostReadMoreTextView> {
  bool showFullComment = false;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
        TextSpan(
          text: widget.lastUserName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextSpan(
          text: showFullComment || widget.lastComment.length < 100
              ? ' ${widget.lastComment}'
              : ' ${widget.lastComment.substring(0, 100)}',
        ),
        widget.lastComment.length > 100 && !showFullComment
            ? TextSpan(
                text: ' ...more',
                style: TextStyle(color: AppColor.callToActionText),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      showFullComment = !showFullComment;
                    });
                  },
              )
            : const TextSpan(),
      ]),
    );
    ;
  }
}
