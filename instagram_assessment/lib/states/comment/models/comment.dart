import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/liked_comment.dart';
import 'package:instagram_assessment/states/comment/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';
import 'package:instagram_assessment/states/post/constants/post_key.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

@immutable
class Comment {
  final CommentId commentId;
  final String comment;
  final PostId postId;
  final UserId userId;
  final DateTime createAt;
  final Iterable<LikedComment> likes;
  final Iterable<Response> responses;

  Comment({required Map<dynamic, dynamic> json, required this.commentId})
      : comment = json[PostKey.comment],
        postId = json[PostKey.postId],
        userId = json[PostKey.userId],
        createAt =
            (json[PostKey.createAt] as Timestamp?)?.toDate() ?? DateTime.now(),
        likes = _parseLikedComments(json[PostKey.likes] as List<dynamic>),
        responses = _parseResponse(json[PostKey.responses] as List<dynamic>);

  static Iterable<LikedComment> _parseLikedComments(List<dynamic>? likes) {
    if (likes == null) {
      return [];
    }
    return likes.map((like) {
      return LikedComment.fromJson(json: like);
    }).toList();
  }

  static Iterable<Response> _parseResponse(List<dynamic>? responses) {
    if (responses == null) {
      return [];
    }
    return responses.map((response) {
      return Response.fromJson(json: response);
    }).toList();
  }
}
