import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_result.dart';
import 'package:instagram_assessment/features/authentication/data/backend/provider/auth_state_provider.dart';

final isLoggedInProvider = Provider<bool>(
  (ref) {
    final authState = ref.watch(authStateProvider);

    return authState.authResult == AuthResult.success;
  },
);
