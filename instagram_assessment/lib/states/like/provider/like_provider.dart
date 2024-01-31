import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/like/models/like.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';
import 'package:riverpod/riverpod.dart';

final likeProvider = StreamProvider.family.autoDispose<Iterable<Like>, PostId>(
  (ref, PostId postId) {
    final controller = StreamController<Iterable<Like>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.likes)
        .where(FirebaseFieldName.postId, isEqualTo: postId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final likes = snapshot.docs.map(
          (doc) => Like(
            json: doc.data(),
          ),
        );
        controller.sink.add(likes);
      }
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });

    return controller.stream;
  },
);
