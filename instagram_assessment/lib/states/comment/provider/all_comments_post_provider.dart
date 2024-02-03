import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/extension/comment_sorting_by_request.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final allCommentsPostProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, CommentPostRequest>(
        (ref, CommentPostRequest request) async* {
  final controller = StreamController<Iterable<Comment>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snapshot) {
    final document = snapshot.docs;
    final comments = document.map(
      (document) => Comment(
        json: document.data(),
        commentId: document.id,
      ),
    );

    final result = comments.applySortingFrom(request);

    controller.sink.add(result);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  yield* controller.stream;
});
