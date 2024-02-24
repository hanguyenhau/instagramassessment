import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/auth_firebase.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/user_info_storage.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/models/typedef.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    ref.watch(authFirebaseSourceProvider),
    ref.watch(userInfoStorageProvider),
  ),
);

@immutable
class AuthRepository {
  final AuthFirebaseSource _authDataSource;
  final UserInfoStorage _userStorage;

  const AuthRepository(this._authDataSource, this._userStorage) : super();

  Future<AuthResult> loginWithGoogle() async {
    final result = await _authDataSource.loginWithGoogle();
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(uId: userId!);
    }
    return result;
  }

  Future<void> signOut() async {
    return _authDataSource.signOut();
  }

  Future<void> saveUserInfo({required UserId uId}) => _userStorage.saveUserInfo(
      uId: uId, uName: displayName, uEmail: email, uImage: image);
}
