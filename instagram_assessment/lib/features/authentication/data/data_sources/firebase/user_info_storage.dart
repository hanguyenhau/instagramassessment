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
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';

final userInfoStorageProvider = Provider(
  (ref) => UserInfoStorage(
    firestore: ref.read(firestoreProvider),
  ),
);

@immutable
class UserInfoStorage {
  final FirebaseFirestore _firestore;

  const UserInfoStorage({required FirebaseFirestore firestore})
      : _firestore = firestore;

  FutureEither<bool> saveNewUserInfo({
    required UserModel user,
  }) async {
    try {
      //check if user id existed
      final userInfo = await getUserData(uId: user.userId);

      if (userInfo != null) {
        return right(true);
      }

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

  Future<UserModel?> getUserData({
    required UserId uId,
  }) async {
    //check if user id existed
    final userQuery = await _firestore
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.userId, isEqualTo: uId)
        .limit(1)
        .get();

    return userQuery.docs.isNotEmpty
        ? UserModel.fromJson(
            json: userQuery.docs.first.data(),
          )
        : null;
  }
}
