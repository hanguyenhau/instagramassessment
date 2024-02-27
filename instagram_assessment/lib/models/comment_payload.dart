import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

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
