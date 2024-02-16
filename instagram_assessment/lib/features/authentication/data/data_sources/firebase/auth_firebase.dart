import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/constants/constants.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';

@immutable
class FirebaseAuthDataSource {
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: [Constants.emailScope]);

  Future<AuthResult> loginWithGoogle() async {
    final signInAccount = await _googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    try {
      await FirebaseAuth.instance.signInWithCredential(oauthCredentials);
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
  }
}
