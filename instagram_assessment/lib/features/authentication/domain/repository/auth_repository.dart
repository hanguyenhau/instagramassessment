import 'package:flutter/material.dart';

@immutable
abstract class AuthRepository<T> {
  Future<T> loginWithGoogle();

  Future<void> signOut();
}
