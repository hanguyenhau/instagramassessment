import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/post_key.dart';

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
