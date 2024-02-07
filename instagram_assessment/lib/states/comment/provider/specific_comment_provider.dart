import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/comment/models/comment.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';

final specificCommentProvider =
    StreamProvider.family.autoDispose<Comment, CommentId>(
  (ref, CommentId commentId) {
    final controller = StreamController<Comment>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .where(FieldPath.documentId, isEqualTo: commentId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final comment = Comment.fromJson(
        commentId: doc.id,
        json: json,
      );
      controller.add(comment);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });

    return controller.stream;
  },
);
