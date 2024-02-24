import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/models/like_response.dart';
import 'package:instagram_assessment/states/comment/component/responses/type_def/response_id.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';

@immutable
class Response {
  final ResponseId responseId;
  final String comment;
  final UserId userId;
  final DateTime createAt;
  final Iterable<LikeResponse> likes;

  Response.fromJson(
      {required Map<dynamic, dynamic> json, required this.responseId})
      : comment = json[PostKey.comment],
        userId = json[PostKey.userId],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.timestamp(),
        likes = _parseLikedComments(json[PostKey.likes] as List<dynamic>);

  static Iterable<LikeResponse> _parseLikedComments(List<dynamic>? likes) {
    if (likes == null) {
      return [];
    }
    return likes.map((like) {
      return LikeResponse.fromJson(json: like);
    }).toList();
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Response &&
          runtimeType == other.runtimeType &&
          responseId == other.responseId &&
          comment == other.comment &&
          createAt == other.createAt &&
          userId == other.userId &&
          likes == other.likes;

  @override
  int get hashCode => Object.hashAll([
        responseId,
        comment,
        createAt,
        createAt,
        userId,
        likes,
      ]);
}
