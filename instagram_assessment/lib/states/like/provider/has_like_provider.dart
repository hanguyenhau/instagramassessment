import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';
import 'package:instagram_assessment/features/user/controller/user_controller.dart';
import 'package:instagram_assessment/models/typedef.dart';

final hasLikeProvider = StreamProvider.family.autoDispose<bool, PostId>((ref, PostId postId) {
  final controller = StreamController<bool>();

  final userId = ref.read(userProvider);
  if(userId == null){
    return Stream<bool>.value(false);
  }

  final sub = FirebaseFirestore.instance
  .collection(FirebaseCollectionName.likes)
  .where(FirebaseFieldName.postId, isEqualTo: postId)
  .where(FirebaseFieldName.userId, isEqualTo: userId)
  .snapshots().listen((snapshot) { 
    if(snapshot.docs.isNotEmpty){
      controller.add(true);
    }else{
      controller.add(false);
    }
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
},);