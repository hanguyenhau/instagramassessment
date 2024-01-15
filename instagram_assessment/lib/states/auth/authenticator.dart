import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:instagram_assessment/constants/state/constants.dart';
import 'package:instagram_assessment/models/auth_result.dart';
import 'package:instagram_assessment/typedef/user_id.dart';

class Authenticator {
  const Authenticator();

  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  bool get isAlreadyLoggedIn => userId != null;

  //Sign in with google
  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: [Constants.emailScope]);

    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }
    //signInAccount.authentication chứa thông tin xác thực bao gồm accessTojen và idToken
    //accessToken: là là chuỗi token sử dụng thực hiện yêu cầu các dịch vụ của Google
    //idToken: là chuỗi JWT(Json Web Token) chứa thông tin về người dùng và quyển truy cập
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
    await GoogleSignIn().signOut();
  }
}
