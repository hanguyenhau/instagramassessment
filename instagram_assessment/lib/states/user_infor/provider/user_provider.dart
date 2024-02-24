import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final userProvider = StreamProvider.family.autoDispose<UserModel, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserModel>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final userInfo = UserModel.fromJson(
        json: json,
      );
      controller.add(userInfo);
    });

    ref.onDispose(() {
      controller.close();
      sub.cancel();
    });

    return controller.stream;
  },
);
