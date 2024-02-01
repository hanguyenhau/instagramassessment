import 'package:flutter/material.dart';
import 'package:instagram_assessment/views/view/comment/app_bar_comment.dart';
import 'package:instagram_assessment/views/view/comment/comment_list.dart';

class CommentsDialog extends StatelessWidget {
  const CommentsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarComment(),
      ),
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const CommentList();
                }),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.0,
                right: 8.0,
              ),
              child: TextFormField(
                textInputAction: TextInputAction.send,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Strings.writeYourCommentHere',
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
