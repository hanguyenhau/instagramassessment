import 'dart:async';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/post/models/post.dart';

final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final controller = StreamController<Iterable<Post>>();

    log('xxx');

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        // .orderBy(
        //   FirebaseFieldName.createAt,
        //   descending: true,
        // )
        .snapshots()
        .listen((snapshot) {
      final posts = snapshot.docs.map(
        (doc) => Post(
          postId: doc.id,
          json: doc.data(),
        ),
      );

      controller.sink.add(posts);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });
    return controller.stream;
  },
);
