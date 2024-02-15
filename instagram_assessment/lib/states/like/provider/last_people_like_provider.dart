import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/like/models/like.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

final lastLikeLikeProvider = StreamProvider.family.autoDispose<Like?, PostId>(
  (ref, PostId postId) async* {
    final controller = StreamController<Like?>();

    try {
      final sub = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .orderBy(FirebaseFieldName.createAt, descending: true)
          .limit(1)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isNotEmpty) {
          final lastLike = snapshot.docs
              .map(
                (doc) => Like(
                  json: doc.data(),
                ),
              )
              .first;
          controller.sink.add(lastLike);
        } else {
          controller.sink.add(null);
        }
      });

      ref.onDispose(() {
        controller.close();
        sub.cancel();
      });
    } catch (e) {}

    yield* controller.stream;
  },
);
