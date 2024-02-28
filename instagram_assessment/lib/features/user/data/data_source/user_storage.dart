import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
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

  Future<bool> saveUserInfo({
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

      return true;
    } catch (e) {
      throw e.toString();
    }
  }

  Stream<UserModel> getUserData({
    required UserId uId,
  }) =>
      _users
          .where(FirebaseFieldName.userId, isEqualTo: uId)
          .limit(1)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) =>
                  UserModel.fromJson(json: doc.data() as Map<String, dynamic>))
              .first);

  Stream<Iterable<UserModel>> allUsers() =>
      _users.snapshots().map((snapshot) => snapshot.docs.map(
            (doc) => UserModel.fromJson(
              json: doc.data() as Map<String, dynamic>,
            ),
          ));
}
