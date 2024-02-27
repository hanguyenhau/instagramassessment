import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

final totalAllResponses = StreamProvider.family
    .autoDispose<int, CommentId>((ref, CommentId commentId) {
  final controller = StreamController<int>.broadcast();

  controller.onListen = () {
    controller.sink.add(0);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .doc(commentId)
      .collection(FirebaseFieldName.responses)
      .snapshots()
      .listen((snapshot) {
    controller.sink.add(snapshot.docs.length);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });
  
  return controller.stream;
});

