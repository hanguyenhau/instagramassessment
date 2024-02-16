import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/features/authentication/domain/entities/user_id.dart';
import 'package:instagram_assessment/states/constants/firebase_collection_name.dart';
import 'package:instagram_assessment/states/constants/firebase_field_name.dart';
import 'package:instagram_assessment/states/user_infor/models/user_payload.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();

  Future<bool> saveUserInfo({
    required UserId uId,
    required String uName,
    required String? uEmail,
    required String? uImage,
  }) async {
    try {
      //check if user id existed
      final userInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.userId, isEqualTo: uId)
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        return true;
      }

      //if not empty
      final payload = UserPayLoad(
        userId: uId,
        displayName: uName,
        email: uEmail,
        image: uImage
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.users)
          .add(payload);

      return true;
    } catch (e) {
      return false;
    }
  }
}
