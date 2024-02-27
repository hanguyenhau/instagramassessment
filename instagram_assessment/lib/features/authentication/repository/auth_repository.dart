import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/config/core/constants/firebase_constants.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/auth_firebase.dart';
import 'package:instagram_assessment/features/user/data/data_source/user_storage.dart';
import 'package:instagram_assessment/models/typedef.dart';
import 'package:instagram_assessment/models/user.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    ref.watch(authFirebaseSourceProvider),
    ref.watch(userStorageProvider),
  ),
);

@immutable
class AuthRepository {
  final AuthFirebaseSource _authDataSource;
  final UserStorage _storage;

  const AuthRepository(this._authDataSource, this._storage) : super();

  UserId? get currentId => _authDataSource.userId;

  Future<UserModel?> loginWithGoogle() async {
    try {
      final userCredential = await _authDataSource.loginWithGoogle();
      if (userCredential == null) {
        return null;
      }
      final UserModel currentUserInfo;

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        //save to firestore
        currentUserInfo = UserModel(
            image:
                userCredential.user!.photoURL ?? FirebaseConstants.defaultPhoto,
            userId: userCredential.user!.uid,
            displayName: userCredential.user!.displayName ??
                FirebaseConstants.defaultName,
            email: userCredential.user!.email ?? '');
        await _storage.saveUserInfo(user: currentUserInfo);
      } else {
        currentUserInfo =
            await _storage.getUserData(uId: userCredential.user!.uid);
      }
      return currentUserInfo;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    return _authDataSource.signOut();
  }
}
