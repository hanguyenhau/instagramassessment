import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_assessment/config/core/constants/post_key.dart';
import 'package:instagram_assessment/models/typedef.dart';

@immutable
class Follow {
  final FollowId followId;
  final UserId userId;
  final DateTime createAt;

  Follow.fromJson({required Map<dynamic, dynamic> json, required this.followId})
      : userId = json[PostKey.userId],
        createAt = (json[PostKey.createAt] as Timestamp?)?.toDate() ??
            DateTime.timestamp();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Follow &&
          runtimeType == other.runtimeType &&
          followId == other.followId &&
          createAt == other.createAt &&
          userId == other.userId;

  @override
  int get hashCode => Object.hashAll([
        followId,
        userId,
      ]);
}
