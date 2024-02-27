import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:instagram_assessment/config/core/failure.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/config/core/typedefs.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';
import 'package:instagram_assessment/models/user_payload.dart';
import 'package:instagram_assessment/config/core/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/config/core/constants/firebase_field_name.dart';

final userStorageProvider = Provider(
  (ref) => UserStorage(
    firestore: ref.read(firestoreProvider),
  ),
);

@immutable
class UserStorage {
  final FirebaseFirestore _firestore;

  const UserStorage({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseCollectionName.users);

  FutureEither<bool> saveUserInfo({
    required UserModel user,
  }) async {
    try {
      //if not empty
      final payload = UserModelPayLoad(
        userId: user.userId,
        displayName: user.displayName,
        email: user.email,
        image: user.image,
      );
      await _firestore.collection(FirebaseCollectionName.users).add(payload);

      return right(true);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Future<UserModel> getUserData({
    required UserId uId,
  }) async {
    //check if user id existed
    final userQuery = await _users
        .where(FirebaseFieldName.userId, isEqualTo: uId)
        .limit(1)
        .get();

    return UserModel.fromJson(
      json: userQuery.docs.first.data() as Map<String, dynamic>,
    );
  }

  // Stream<UserModel> getUserData(String uid) {
  //   return _users.doc(uid).snapshots().map((snapshot) {
  //     return UserModel.fromJson(json: snapshot.data());
  //   });
  // }
}
