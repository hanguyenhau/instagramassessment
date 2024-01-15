import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/models/auth_result.dart';
import 'package:instagram_assessment/states/provider/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);
    print(
      'isLoggedInProvider: ${FirebaseAuth.instance.currentUser?.displayName} and bool is ${authState.authResult == AuthResult.success}',
    );
    return authState.authResult == AuthResult.success;
  },
);
