import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class Like extends MapView<String, String> {
  final UserId userId;
  final PostId postId;
  final DateTime createAt;

  Like({required this.userId, required this.postId, required this.createAt})
      : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.createAt: createAt.toIso8601String(),
        });
}
