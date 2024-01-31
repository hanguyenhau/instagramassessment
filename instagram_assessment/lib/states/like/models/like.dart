import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class Like {
  final UserId userId;
  final PostId postId;
  final DateTime createAt;

  Like({required Map<String, dynamic> json})
      : userId = json[PostKey.userId],
        postId = json[PostKey.postId],
        createAt = (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.now();
}
