import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/like/models/like_payload.dart';
import 'package:instagram_assessment/states/like/models/like_request.dart';

final likeDislikeActionProvider =
    FutureProvider.family.autoDispose<bool, LikeRequest>(
  (ref, LikeRequest likeRequest) async {
    final query = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.postId, isEqualTo: likeRequest.postId)
        .where(FirebaseFieldName.userId, isEqualTo: likeRequest.likedBy)
        .get();

    //check if liked or not
    final hasLiked = await query.then(
      (snapshot) => snapshot.docs.isNotEmpty,
    );

    log('hasLiked: $hasLiked');

    if (hasLiked) {
      try {
        //delete liked
        await query.then((snapshot) async {
          for (final doc in snapshot.docs) {
            await doc.reference.delete();
          }
        });
        return true;
      } catch (e) {
        return false;
      }
    } else {
      //post liked
      final like = LikePayLoad(
        userId: likeRequest.likedBy,
        postId: likeRequest.postId,
      );
      try {
        await FirebaseFirestore.instance
            .collection(FirebaseCollectionName.likes)
            .add(like);

        return true;
      } catch (e) {
        return false;
      }
    }
  },
);
