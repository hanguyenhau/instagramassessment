import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/liked_comment.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';

@immutable
class Response {
  final String comment;
  final UserId userId;
  final DateTime createAt;
  // final Iterable<LikedComment> likes;

  Response({required Map<dynamic, dynamic> json})
      : comment = json[PostKey.comment],
        userId = json[PostKey.userId],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.now();
  //       likes = _parseLikes(json[PostKey.likes]);

  // static Iterable<LikedComment> _parseLikes(dynamic json) {
  //   if (json is List) {
  //     return json.map((like) => LikedComment(json: like)).toList();
  //   }
  //   return [];
  // }
}
