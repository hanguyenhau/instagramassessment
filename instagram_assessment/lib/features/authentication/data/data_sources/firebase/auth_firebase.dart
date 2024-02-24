import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_assessment/config/core/constants/firebase_constants.dart';
import 'package:instagram_assessment/config/core/failure.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/config/core/typedefs.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/user_info_storage.dart';
import 'package:instagram_assessment/models/user.dart';

final authFirebaseSourceProvider = Provider(
  (ref) => AuthFirebaseSource(
    googleSignIn: ref.read(googleSignInProvider),
    auth: ref.read(authProvider),
    storage: ref.watch(userInfoStorageProvider),
  ),
);

@immutable
class AuthFirebaseSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;
  final UserInfoStorage _storage;

  const AuthFirebaseSource({
    required UserInfoStorage storage,
    required GoogleSignIn googleSignIn,
    required FirebaseAuth auth,
  })  : _googleSignIn = googleSignIn,
        _auth = auth,
        _storage = storage;

  //loginWithGoogle
  FutureEither<UserModel> loginWithGoogle() async {
    final signInAccount = await _googleSignIn.signIn();
    if (signInAccount == null) {
      return left(Failure('Error google sign in'));
    }
    try {
      final googleAuth = await signInAccount.authentication;
      final oauthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredentials);
      final UserModel currentUserInfo = UserModel(
          image:
              userCredential.user!.photoURL ?? FirebaseConstants.defaultPhoto,
          userId: userCredential.user!.uid,
          displayName:
              userCredential.user!.displayName ?? FirebaseConstants.defaultName,
          email: userCredential.user!.email ?? '');

      if (userCredential.additionalUserInfo?.isNewUser ?? false) {
        //save to firestore
        await _storage.saveNewUserInfo(user: currentUserInfo);
        return right(currentUserInfo);
        
      } else {
        final existedUser =
            await _storage.getUserData(uId: userCredential.user!.uid) ??
                currentUserInfo;
        return right(existedUser);
      }
    } catch (e) {
      return left(
        Failure(
          e.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
