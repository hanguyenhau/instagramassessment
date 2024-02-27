import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

@immutable
class LikeResponse extends MapView<String, dynamic> {
  final UserId userId;
  final DateTime createAt;

  LikeResponse({
    required this.userId,
    required this.createAt,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createAt: createAt,
        });

  LikeResponse.fromJson({required Map<dynamic, dynamic> json})
      : this(
          userId : json[FirebaseFieldName.userId],
          createAt :
              (json[FirebaseFieldName.createAt] as Timestamp?)?.toDate() ??
                  DateTime.now(),
        );
}
