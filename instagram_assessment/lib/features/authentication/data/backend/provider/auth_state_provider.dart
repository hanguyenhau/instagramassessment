import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_assessment/features/authentication/data/backend/notifier/auth_state_notifier.dart';
import 'package:instagram_assessment/features/authentication/data/models/auth_state.dart';

final authStateProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
    (ref) => AuthStateNotifier());
