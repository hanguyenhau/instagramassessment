import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';

@immutable
class Response extends MapView<String, dynamic> {
  final String comment;
  final UserId userId;
  final DateTime createAt;

  Response(
      {required this.comment, required this.userId, required this.createAt})
      : super({
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createAt: createAt,
        });

  Response.fromJson({required Map<String, dynamic> json})
      : this(
          comment: json[PostKey.comment],
          userId: json[PostKey.userId],
          createAt: (json[PostKey.createAt] as Timestamp?)?.toDate() ??
              DateTime.now(),
        );
}
