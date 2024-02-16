import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/features/authentication/domain/entities/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

@immutable
class LikedComment extends MapView<String, dynamic> {
  final UserId userId;
  final DateTime createAt;

  LikedComment({
    required this.userId,
    required this.createAt,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createAt: createAt,
        });

  LikedComment.fromJson({required Map<dynamic, dynamic> json})
      : this(
          userId : json[FirebaseFieldName.userId],
          createAt :
              (json[FirebaseFieldName.createAt] as Timestamp?)?.toDate() ??
                  DateTime.now(),
        );
}
