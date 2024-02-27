import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_assessment/config/core/providers/firebase_provider.dart';
import 'package:instagram_assessment/models/typedef.dart';

final authFirebaseSourceProvider = Provider(
  (ref) => AuthFirebaseSource(
      googleSignIn: ref.read(googleSignInProvider),
      auth: ref.read(authProvider)),
);

@immutable
class AuthFirebaseSource {
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _auth;

  const AuthFirebaseSource({
    required GoogleSignIn googleSignIn,
    required FirebaseAuth auth,
  })  : _googleSignIn = googleSignIn,
        _auth = auth;

  UserId? get userId => _auth.currentUser?.uid;

  //loginWithGoogle
  Future<UserCredential?> loginWithGoogle() async {
    final signInAccount = await _googleSignIn.signIn();
    if (signInAccount == null) {
      return null;
    }
    try {
      final googleAuth = await signInAccount.authentication;
      final oauthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(oauthCredentials);
      return userCredential;
    } catch (e) {
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}
