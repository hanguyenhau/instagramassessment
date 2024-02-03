import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/backend/comment_storage.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/liked_comment.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/upload_image/type_def/is_loading.dart';

class CommentNotifier extends StateNotifier<IsLoading> {
  final commentStorage = const CommentStorage();

  CommentNotifier() : super(false);

  set isLoading(bool value) => state = value;

  Future<bool> likeDislikeAction(LikeCommentRequest request) async {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FieldPath.documentId, isEqualTo: request.comment.commentId)
        .get();

    try {
      DocumentReference commentReference = query.docs.first.reference;

      final likes = request.comment.likes.toList();

      if (likes.any((element) => element.userId == request.likedBy)) {
        likes.removeWhere((element) => element.userId == request.likedBy);
      } else {
        likes.add(
          LikedComment(
            userId: request.likedBy,
            createAt: DateTime.now(),
          ),
        );
      }

      //delete liked
      await commentReference.update({
        FirebaseFieldName.likes: likes,
        // You can add more fields to update here if needed
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
