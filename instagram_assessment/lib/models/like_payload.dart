import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

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
