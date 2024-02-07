import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/comment/component/responses/models/response.dart';
import 'package:instagram_assessment/states/comment/typedef/comment_id.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final allResponsesProvider =
    StreamProvider.family.autoDispose<Iterable<Response>, CommentId>(
  (ref, CommentId commentId) {
    final controller = StreamController<Iterable<Response>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.comments)
        .doc(commentId)
        .collection(FirebaseFieldName.responses)
        // .orderBy(
        //   FirebaseFieldName.createAt,
        //   descending: true
        // )
        .snapshots()
        .listen((snapshot) {
      final response = snapshot.docs.map(
        (doc) => Response.fromJson(
          json: doc.data(),
          responseId: doc.id,
        ),
      );

      controller.sink.add(response);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });
    return controller.stream;
  },
);
