import 'package:flutter/foundation.dart';
import 'package:instagram_assessment/states/auth/models/auth_result.dart';

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

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (authResult == other.authResult &&
          userid == other.userid &&
          isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(authResult, userid, isLoading);
}
