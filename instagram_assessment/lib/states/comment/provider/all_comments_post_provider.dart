import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/extension/comment_sorting_by_request.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/comment_post_request.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final allCommentsPostProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, CommentPostRequest>(
        (ref, CommentPostRequest request) {
  final controller = StreamController<Iterable<Comment>>();

  log("comments get");

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldName.createAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final document = snapshot.docs;
    final comments = document.map(
      (document) => Comment.fromJson(
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

  return controller.stream;
});
