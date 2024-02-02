import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class Comment {
  final String comment;
  final PostId postId;
  final UserId userId;
  final DateTime createAt;

  Comment({required Map<String, dynamic> json})
      : comment = json[PostKey.comment],
        postId = json[PostKey.postId],
        userId = json[PostKey.userId],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.now();
}
