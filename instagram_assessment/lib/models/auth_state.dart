import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/models/auth_result.dart';

@immutable
class AuthState {
  final String? userid;
  final AuthResult? authResult;
  final bool isLoading;

  const AuthState(
      {required this.userid,
      required this.authResult,
      required this.isLoading});

  const AuthState.unknown()
      : authResult = null,
        isLoading = false,
        userid = null;

  AuthState coppiedWithIsLoading(bool isLoading) => AuthState(
        userid: userid,
        authResult: authResult,
        isLoading: isLoading,
      );

  //AuthState unknowns() {
  //  return AuthState(userid: null, authResult: null, isLoading: false);
  //}
}
