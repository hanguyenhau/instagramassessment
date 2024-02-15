import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

final lastCommentPostProvider =
    StreamProvider.family.autoDispose<Comment?, PostId>(
  (ref, PostId postId) async* {
    final controller = StreamController<Comment?>();

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .orderBy(FirebaseFieldName.createAt, descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final document = snapshot.docs.first;
        final comment = Comment.fromJson(
          json: document.data(),
          commentId: document.id,
        );
        controller.sink.add(comment);
      }
    } catch (e) {
      controller.sink.add(null);
    }

    ref.onDispose(() {
      controller.close();
    });

    yield* controller.stream;
  },
);
