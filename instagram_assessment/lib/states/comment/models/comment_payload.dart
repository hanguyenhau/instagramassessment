import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class CommentPayLoad extends MapView<String, dynamic> {
  CommentPayLoad({
    required String comment,
    required PostId postId,
    required UserId userId,
  }) : super({
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.createAt: FieldValue.serverTimestamp(),
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.likes: [],
        });
}
