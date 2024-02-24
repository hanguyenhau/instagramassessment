import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';

final allUsersProvider = StreamProvider.autoDispose<Iterable<UserModel>>(
  (ref) {
    final controller = StreamController<Iterable<UserModel>>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .snapshots()
        .listen((snapshot) {
      final users = snapshot.docs.map(
        (doc) => UserModel.fromJson(
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
