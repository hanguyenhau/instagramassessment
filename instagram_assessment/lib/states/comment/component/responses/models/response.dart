import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/comment/component/responses/type_def/response_id.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';

@immutable
class Response {
  final ResponseId? responseId;
  final String comment;
  final UserId userId;
  final DateTime createAt;

  const Response({
    required this.comment,
    required this.userId,
    required this.createAt,
    this.responseId,
  });

  Response.fromJson(
      {required Map<dynamic, dynamic> json, required this.responseId})
      : comment = json[PostKey.comment],
        userId = json[PostKey.userId],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.now();
}
