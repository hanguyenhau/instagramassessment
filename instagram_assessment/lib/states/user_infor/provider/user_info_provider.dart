import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/states/auth/typedef/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/user_infor/models/user_info.dart';

final userInfoProvider = StreamProvider.family.autoDispose<UserInfo, UserId>(
  (ref, UserId userId) {
    final controller = StreamController<UserInfo>();

    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: userId)
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final userInfo = UserInfo.fromJson(
        json,
        userId: userId,
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
