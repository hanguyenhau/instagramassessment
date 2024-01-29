import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

@immutable
class UserInfo extends MapView<String, String?> {
  final String userId;
  final String displayName;
  final String? email;
  final String image;

  UserInfo({
    required this.image,
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
          FirebaseFieldName.image: image,
        });

  UserInfo.fromJson(Map<String, dynamic> json, {required UserId userId})
      : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
          image: json[FirebaseFieldName.image],
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfo &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          image == other.image;
  @override
  int get hashCode => Object.hashAll([
        userId,
        displayName,
        email,
        image,
      ]);
}
