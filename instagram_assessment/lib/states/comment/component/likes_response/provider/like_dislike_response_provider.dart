import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/models/like_response.dart';
import 'package:instagram_assessment/states/comment/component/likes_response/models/like_response_request.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

final likeDislikeResponseProvider = FutureProvider.family
    .autoDispose<bool, LikeResponseRequest>(
        (ref, LikeResponseRequest request) async {
  try {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .doc(request.commentId)
        .collection(FirebaseFieldName.responses)
        .doc(request.response.responseId)
        .get();

    if (!query.exists) {
      return false;
    }

    DocumentReference commentReference = query.reference;

    final likes = List.from(request.response.likes);

    //if list likes exist
    final hasLike = likes.any((element) => element.userId == request.likedBy);

    if (hasLike) {
      //if exist then remove
      likes.removeWhere((element) => element.userId == request.likedBy);
    } else {
      //if not exist add to list
      likes.add(
        LikeResponse(
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
