import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/data_sources/firebase/auth_firebase.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/data/repository/auth_repository_impl.dart';
import 'package:instagram_assessment/features/authentication/data/services/auth_service.dart';

final authController = FutureProvider<AuthResult>((ref) async {
  final authService = ref.read(authServiceProvider);
  return authService.loginWithGoogle();
});
// Providers

final authRepositoryProvider = Provider((ref) => AuthRepositoryImpl(FirebaseAuthDataSource()));

final authServiceProvider = Provider((ref) => AuthService(ref.read(authRepositoryProvider)));