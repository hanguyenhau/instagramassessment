import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/models/typedef.dart';

@immutable
class FollowPayLoad extends MapView<String, dynamic> {
  FollowPayLoad({
    required UserId userId,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.createAt: FieldValue.serverTimestamp(),
        });
}
