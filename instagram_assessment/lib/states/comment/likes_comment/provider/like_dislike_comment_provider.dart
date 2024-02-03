import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/like_comment_request.dart';
import 'package:instagram_assessment/states/comment/likes_comment/models/liked_comment.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final likeDislikeCommentProvider = FutureProvider.family
    .autoDispose<bool, LikeCommentRequest>(
        (ref, LikeCommentRequest request) async {
  try {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .doc(request.comment.commentId)
        .get();

    if (!query.exists) {
      return false;
    }

    DocumentReference commentReference = query.reference;

    final likes = List.from(request.comment.likes);

    //if list likes exist
    final hasLike = likes.any((element) => element.userId == request.likedBy);

    if (hasLike) {
      //if exist then remove
      likes.removeWhere((element) => element.userId == request.likedBy);
    } else {
      //if not exist add to list
      likes.add(
        LikedComment(
          userId: request.likedBy,
          createAt: DateTime.now(),
        ),
      );
    }

    //update all likes
    await commentReference.update({
      FirebaseFieldName.likes: likes,
      // You can add more fields to update here if needed
    });
    return true;
  } catch (e) {
    return false;
  }
});
