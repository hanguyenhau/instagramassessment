import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/extension/comment_sorting_by_request.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/models/enum/date_sorting.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/typedef/post_id.dart';

final allCommentsPostProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>?, PostId>(
        (ref, PostId postId) {
  final controller = StreamController<Iterable<Comment>?>();

  try {
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FirebaseFieldName.postId, isEqualTo: postId)
        .orderBy(FirebaseFieldName.createAt, descending: true)
        .snapshots()
        .listen((snapshot) {
      final document = snapshot.docs;
      if (document.isNotEmpty) {
        final comments = document.map(
          (document) => Comment.fromJson(
            json: document.data(),
            commentId: document.id,
          ),
        );

        final result = comments.applySortingFrom(DateSorting.newestOnTop);

        controller.sink.add(result);
      } else {
        controller.sink.add(null);
      }
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });
  } catch (e) {}

 return controller.stream;
});
