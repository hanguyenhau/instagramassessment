import 'package:instagram_assessment/models/auth_result.dart';

class AuthState {
  final String? userid;
  final AuthResult? authResult;
  final bool? isLoading;

  AuthState({this.userid, this.authResult, this.isLoading});

  AuthState.unknown()
      : authResult = null,
        isLoading = false,
        userid = null;

  //AuthState unknowns() {
  //  return AuthState(userid: null, authResult: null, isLoading: false);
  //}
}
