import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/user_infor/models/user.dart';

final allUsersProvider = StreamProvider.autoDispose<Iterable<User>>(
  (ref) {
    final controller = StreamController<Iterable<User>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .snapshots()
        .listen((snapshot) {
      final users = snapshot.docs.map(
        (doc) => User.fromJson(
          userId: doc.id,
          json: doc.data(),
        ),
      );
      controller.sink.add(users);
    });

    ref.onDispose(() {
      controller.onCancel;
      sub.cancel();
    });

    return controller.stream;
  },
);
