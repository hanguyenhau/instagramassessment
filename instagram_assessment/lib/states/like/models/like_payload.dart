import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class LikePayLoad extends MapView<String, dynamic> {
  LikePayLoad({
    required UserId userId,
    required PostId postId,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.createAt: FieldValue.serverTimestamp(),
        });
}
