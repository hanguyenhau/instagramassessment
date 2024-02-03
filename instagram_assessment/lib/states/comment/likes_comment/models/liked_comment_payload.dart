import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

@immutable
class LikedCommentPayload extends MapView<String, dynamic> {
  LikedCommentPayload({
    required UserId userId,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createAt: FieldValue.serverTimestamp(),
        });
}
