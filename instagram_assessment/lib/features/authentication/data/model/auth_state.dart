import 'package:flutter/material.dart';
import 'package:instagram_assessment/features/authentication/data/model/auth_result.dart';
import 'package:instagram_assessment/models/user.dart';

@immutable
class AuthState {
  final UserModel? currentUser;
  final AuthResult? authResult;
  final bool isLoading;

  const AuthState(
      {required this.currentUser,
      required this.authResult,
      required this.isLoading});

  const AuthState.unknown()
      : authResult = null,
        isLoading = false,
        currentUser = null;

  AuthState coppiedWithIsLoading(bool isLoading) => AuthState(
        currentUser: currentUser,
        authResult: authResult,
        isLoading: isLoading,
      );

  const AuthState.updatedAuthResult(AuthResult this.authResult, UserModel? user)
      : isLoading = false,
        currentUser = user;

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (authResult == other.authResult &&
          currentUser == other.currentUser &&
          isLoading == other.isLoading);

  @override
  int get hashCode => Object.hash(authResult, currentUser, isLoading);
}
